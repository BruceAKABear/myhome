package pro.dengyi.myhome.config;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * quartz任务
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
public class QuartzJob implements Job {

  @Override
  public void execute(JobExecutionContext context) throws JobExecutionException {
    System.out.println("quartz job");
  }
}
