package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface InterCommand {
	
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
}
