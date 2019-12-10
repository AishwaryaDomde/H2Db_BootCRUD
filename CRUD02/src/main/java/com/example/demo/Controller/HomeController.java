package com.example.demo.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.model.CandidatesModel;
import com.example.demo.service.CandidateService;
import com.example.demo.service.UserService;

@Controller
public class HomeController {
	@Autowired 
	private CandidateService CandidateService;
	
	@Autowired
	private UserService  UserService;
	
	@RequestMapping("home")
	public ModelAndView home(HttpServletRequest request) {
		System.out.println("In Home Controller..");
		ModelAndView model = new ModelAndView();
		model.setViewName("home");
		String candatsString = CandidateService.get();
		model.addObject("candidates_data",candatsString);	
		String UserService1 = UserService.getDetails();
		model.addObject("UserService",UserService1);	
		return model;
	}
	/**************************************************/
	@RequestMapping("/save")
	public ModelAndView save(@ModelAttribute("candidate") CandidatesModel Candidates) {
		ModelAndView model = new ModelAndView("/home");
		CandidateService.save(Candidates);
		return model;
		
	}
	/**************************************************/
	@RequestMapping("/MCandidate/{id}")
	public ModelAndView get(@PathVariable("id") int id) {
		ModelAndView mav = new ModelAndView("home");
		CandidatesModel CandidateObj = CandidateService.get(id);
		if(CandidateObj == null) {
			throw new RuntimeException("Candidate not found"+id);
		}
		mav.addObject("Candidate", CandidateObj);
		String candatsString = CandidateService.get();
		mav.addObject("candidates_data",candatsString);
		String UserService1 = UserService.getDetails();
		mav.addObject("UserService",UserService1);	
		System.out.println(CandidateObj);
		return mav;
	}
	/*****************************************************/
	@RequestMapping("/DCandidate/{id}")
	public ModelAndView delete(@PathVariable("id") int id) {
		ModelAndView mav = new ModelAndView("home");
		CandidateService.delete(id);
		String list = CandidateService.get();
		mav.addObject("list", list);
		String candatsString = CandidateService.get();
		mav.addObject("candidates_data",candatsString);
		String UserService1 = UserService.getDetails();
		mav.addObject("UserService",UserService1);	
		return mav;
	}
}
