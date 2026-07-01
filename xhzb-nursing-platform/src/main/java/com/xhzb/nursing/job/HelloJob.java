package com.xhzb.nursing.job;


import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class HelloJob {


//    @Scheduled(cron = "10,15,18 * * * * ?")
    public void hello(){
        System.out.println("job hello  " + LocalDateTime.now());
    }
}
