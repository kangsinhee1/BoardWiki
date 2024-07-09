package kr.spring.util;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathConstants;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class BggGameInfo {

	public static void main(String[] args) {
		// 예시 보드게임 ID 목록
		int[] gameIds = { 224517, 161936, 174430, 342942, 233078, 316554, 167791, 115746, 187645, 291457, 162886,
				220308, 12333, 182028, 193738, 84876, 169786, 246900, 173346, 28720, 167355, 266507, 177736, 124361,
				341169, 205637, 266192, 312484, 120677, 295770, 237182, 164928, 192135, 96848, 251247, 199792, 324856,
				183394, 175914, 366013, 285774, 256960, 247763, 3076, 295947, 521, 284378, 102794, 185343, 170216,
				184267, 314040, 31260, 255984, 221107, 161533, 205059, 253344, 126163, 231733, 276025, 2651, 182874,
				244521, 216132, 35677, 266810, 125153, 164153, 251661, 209010, 284083, 124742, 321608, 55690, 200680,
				230802, 28143, 157354, 72125, 201808, 191189, 159675, 317985, 229853, 110327, 25613, 62219, 93, 171623,
				121921, 68448, 279537, 397598, 256916, 264220, 373106, 225694, 155821, 37111 };

		List<String> gameTitles = new ArrayList<>();
		List<String> gameDescriptions = new ArrayList<>();

		for (int gameId : gameIds) {
			try {
				// API URL
				String url = "https://api.geekdo.com/xmlapi/boardgame/" + gameId;

				// XML 문서 파싱
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document doc = builder.parse(new URL(url).openStream());

				// XPath 객체 생성
				XPathFactory xPathfactory = XPathFactory.newInstance();
				XPath xpath = xPathfactory.newXPath();

				// XPath 표현식 준비 (title과 description 가져오기)
				XPathExpression titleExpr = xpath.compile("//name[@sortindex='1' and @primary='true']");
				XPathExpression descriptionExpr = xpath.compile("//description");

				// XPath 표현식을 이용하여 요소 가져오기
				NodeList titleNodes = (NodeList) titleExpr.evaluate(doc, XPathConstants.NODESET);
				NodeList descriptionNodes = (NodeList) descriptionExpr.evaluate(doc, XPathConstants.NODESET);

				// 결과 처리
				if (titleNodes.getLength() > 0) {
					Element titleElement = (Element) titleNodes.item(0);
					String title = titleElement.getTextContent().trim();
					gameTitles.add(title);
				}

				if (descriptionNodes.getLength() > 0) {
					Element descriptionElement = (Element) descriptionNodes.item(0);
					String description = descriptionElement.getTextContent().trim();
					gameDescriptions.add(description);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 결과 출력
//		for (int i = 0; i < gameTitles.size(); i++) {
//			System.out.println("Title 순위 : " + (i + 1) +  gameTitles.get(i));
//			System.out.println("--------------------------------------------------");
//		}

		for (int i = 0; i < gameDescriptions.size(); i++) {
			System.out.println(gameDescriptions.get(i));
		}
	}
}
