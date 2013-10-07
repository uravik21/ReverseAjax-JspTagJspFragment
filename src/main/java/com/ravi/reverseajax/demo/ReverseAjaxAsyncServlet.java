package com.ravi.reverseajax.demo;

import java.io.IOException;
import java.util.concurrent.Executors;

import javax.servlet.AsyncContext;
import javax.servlet.AsyncEvent;
import javax.servlet.AsyncListener;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReverseAjaxAsyncServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String ERROR = "ERROR";
	private static final String TIMEOUT = "TIMEOUT";

	@Override
	protected void doPost(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {
		final String userReportName = request.getParameter("taskName");
		if (userReportName != null) {
			request.getSession().setAttribute("userTaskName", userReportName);
			final AsyncContext asyncContext = request.startAsync();
			asyncContext.addListener(new AsynActionListener(asyncContext));
			asyncContext.setTimeout(Integer.parseInt((String) request
					.getParameter("taskTime")));
			processTimeConsumingTask(asyncContext, userReportName);
		}
	}

	@Override
	protected void doGet(final HttpServletRequest request,
			final HttpServletResponse response) throws SecurityException,
			IOException {
		if (request.getSession().getAttribute("userTaskName") != null) {			
			final AsyncContext asyncContext = request.startAsync();
			asyncContext.addListener(new AsynActionListener(asyncContext));
			asyncContext.setTimeout(10000);
			processTimeConsumingTask(asyncContext, (String) request
					.getSession().getAttribute("userTaskName"));
		}
	}

	private void processTimeConsumingTask(final AsyncContext ctx,
			final String taskName) {
		Executors.newFixedThreadPool(5).execute(new Runnable() {
			@Override
			public void run() {
				try {
					// Task in progress
					Thread.sleep(6000);
					ctx.getResponse().getWriter()
							.write("Task '" + taskName + "' Completed ...");
					ctx.complete();
				} catch (Exception ex) {
				}
			}
		});
	}

	private final class AsynActionListener implements AsyncListener {

		private final AsyncContext asyncContext;

		private AsynActionListener(AsyncContext asyncContext) {
			this.asyncContext = asyncContext;
		}

		@Override
		public void onStartAsync(AsyncEvent aSyncEvent) throws IOException {
		}

		@Override
		public void onComplete(AsyncEvent aSyncEvent) throws IOException {
		}

		@Override
		public void onTimeout(AsyncEvent aSyncEvent) throws IOException {
			asyncContext.getResponse().getWriter().write(TIMEOUT);
			asyncContext.complete();
		}

		@Override
		public void onError(AsyncEvent aSyncEvent) throws IOException {
			asyncContext.getResponse().getWriter().write(ERROR);
			asyncContext.complete();
		}
	}

}
