package com.project.nadaum.culture.show.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.XML;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;


public class XmlParser {

 
    private static final String dataGoActualDeaAptTradeUrl = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period";//?_wadl&type=xml
 

    public Map<String, Object> getActualDealPrice(@RequestParam Map<String, Object> paramMap) throws Exception {
        System.out.println("### getActualDealPrice paramMap=>"+paramMap);
        Map<String, Object> resultMap = new HashMap<>();
 
        try {
 
            StringBuilder urlBuilder = new StringBuilder(dataGoActualDeaAptTradeUrl);
            urlBuilder.append("?"+URLEncoder.encode("ServiceKey", "UTF-8")+"="+"p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D");
//            urlBuilder.append("&"+URLEncoder.encode("DEAL_YMD", "UTF-8")+"="+URLEncoder.encode(paramMap.get("DEAL_YMD").toString(), "UTF-8"));
//            urlBuilder.append("&"+URLEncoder.encode("LAWD_CD", "UTF-8")+"="+URLEncoder.encode(paramMap.get("LAWD_CD").toString(), "UTF-8"));
 
            URL url = new URL(urlBuilder.toString());
 
            System.out.println("###url=>"+url);
 
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");
            System.out.println("Response Code:"+conn.getResponseCode());
 
 
            BufferedReader rd;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
 
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line=rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
 
            //json 변환
            org.json.JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
            String xmlJSONObjString = xmlJSONObj.toString();
            System.out.println("### xmlJSONObjString=>"+xmlJSONObjString);
 
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> map = new HashMap<>();
            map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>(){});
            Map<String, Object> dataResponse = (Map<String, Object>) map.get("response");
            Map<String, Object> body = (Map<String, Object>) dataResponse.get("msgbody");
            Map<String, Object> perforList = null;
 
            perforList = (Map<String, Object>) body.get("perforList");
 
            System.out.println("### map="+map);
            System.out.println("### dataResponse="+dataResponse);
            System.out.println("### body="+body);
            System.out.println("### items="+perforList); 
 
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.clear();
        }
 
        return resultMap;
    }


}
