package kr.spring.util;

import java.io.IOException;
import java.util.UUID;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class KakaoLoginUtil {

    @Value("${oauth2.client.registration.kakao.client-id}")
    private String clientId;

    @Value("${oauth2.client.registration.kakao.client-secret}")
    private String clientSecret;

    @Value("${oauth2.client.registration.kakao.redirect-uri}")
    private String redirectUri;

    private final static String SESSION_STATE = "oauth_state";
    private final static String PROFILE_API_URL = "https://kapi.kakao.com/v2/user/me";

    public String getAuthorizationUrl(HttpSession session) {
        if (clientId == null || clientSecret == null) {
            throw new IllegalStateException("KakaoLoginUtil is not initialized properly. clientId or clientSecret is null.");
        }

        String state = generateRandomString();
        setSession(session, state);

        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(clientId)
                .apiSecret(clientSecret)
                .callback(redirectUri)
                .state(state)
                .build(KakaoLoginApi.instance());

        return oauthService.getAuthorizationUrl();
    }

    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
        if (clientId == null || clientSecret == null) {
            throw new IllegalStateException("KakaoLoginUtil is not initialized properly. clientId or clientSecret is null.");
        }

        String sessionState = getSession(session);
        if (StringUtils.pathEquals(sessionState, state)) {
            OAuth20Service oauthService = new ServiceBuilder()
                    .apiKey(clientId)
                    .apiSecret(clientSecret)
                    .callback(redirectUri)
                    .state(state)
                    .build(KakaoLoginApi.instance());

            OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
            return accessToken;
        }
        return null;
    }

    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    private void setSession(HttpSession session, String state) {
        session.setAttribute(SESSION_STATE, state);
    }

    private String getSession(HttpSession session) {
        return (String) session.getAttribute(SESSION_STATE);
    }

    public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
        if (clientId == null || clientSecret == null) {
            throw new IllegalStateException("KakaoLoginUtil is not initialized properly. clientId or clientSecret is null.");
        }

        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(clientId)
                .apiSecret(clientSecret)
                .callback(redirectUri)
                .build(KakaoLoginApi.instance());

        OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
        oauthService.signRequest(oauthToken, request);
        Response response = request.send();
        return response.getBody();
    }
}
