package project.aboutPet.video.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.aboutPet.controller.CommandHandler;

public class NullHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.sendError( HttpServletResponse.SC_NOT_FOUND);
		return null;
	}

}
