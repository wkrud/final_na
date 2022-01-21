package com.project.nadaum.riot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.nadaum.riot.model.service.RiotService;
import com.project.nadaum.riot.model.vo.LeagueEntry;
import com.project.nadaum.riot.model.vo.Summoner;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/riot")
@Slf4j
public class ApitestController {

	final static String API_KEY = "RGAPI-37ef2d15-9ea1-4637-b56e-7add809d7ee7";

	@Autowired
	private RiotService riotService;

	@RequestMapping("/riotheader.do")
	public void riotheader() {

	}

	@RequestMapping(value = "/riot1.do", method = RequestMethod.GET)
	public String searchSummoner(Model model, HttpServletRequest httpServletRequest, Summoner summoner,LeagueEntry leagueentry) {
		BufferedReader br = null;
		String SummonerName = httpServletRequest.getParameter("nickname").replaceAll(" ", "%20");
		log.info("SummonerName = {}", SummonerName);

		Gson gson = new GsonBuilder().create();
		try {
			String urlstr = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/" + SummonerName
					+ "?api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line;
			}

			log.info("summoner = {}", result);
			JsonElement element = JsonParser.parseString(result);
			JsonObject object = element.getAsJsonObject();
			
			int profileIconId = object.get("profileIconId").getAsInt();
			String name = object.get("name").getAsString();
			String puuid = object.get("puuid").getAsString();
			int summonerLevel = object.get("summonerLevel").getAsInt();
			int revisionDate = object.get("revisionDate").getAsInt();
			String id = object.get("id").getAsString();
			String accountId = object.get("accountId").getAsString();
			summoner = new Summoner(0, accountId, profileIconId, revisionDate, name, id, puuid, summonerLevel);
			log.info("summoner = {}", summoner);

			Summoner dbsummoner = riotService.selectOneSummoner(puuid);
			log.info("dbsummoner = {}", dbsummoner);

			if (dbsummoner == null) {
				int summonerrecord = riotService.insertSummoner(summoner);

				String msg = summonerrecord > 0 ? "summoner 등록 성공!" : "summoner 등록 실패!";
				log.info("msg = {}", msg);
			} else {
				String msg = "이미 db에 저장되어있는 summoner입니다";
				log.info("msg = {}", msg);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		try {
			String urlstr = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/" + summoner.getId()
					+ "?api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8")); 
			String resulttier = "";
			String line;
			while ((line = br.readLine()) != null) { 
				resulttier =resulttier + line;
			}
			log.info("resulttier = {}", resulttier);
			JsonArray element = (JsonArray) JsonParser.parseString(resulttier);
			JsonObject object = (JsonObject) element.get(0);
			
			int wins = object.get("wins").getAsInt();
			int losses = object.get("losses").getAsInt();
			String rank = object.get("rank").getAsString();
			String tier = object.get("tier").getAsString();
			String queueType = object.get("queueType").getAsString();
			int leaguePoints = object.get("leaguePoints").getAsInt();
			String leagueId = object.get("leagueId").getAsString();
			leagueentry = new LeagueEntry(0,leagueId,queueType,tier,rank,leaguePoints,wins,losses);
			log.info("leagueentry = {}", leagueentry);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		model.addAttribute("summoner", summoner);
		model.addAttribute("img", "http://ddragon.leagueoflegends.com/cdn/12.1.1/img/profileicon/"
				+ summoner.getProfileIconId() + ".png");
		model.addAttribute("leagueentry", leagueentry);
		model.addAttribute("tierImg", "/resources/image/riot/"+leagueentry.getTier()+".png");
		
		

		return "riot/riotheader";

	}

}
