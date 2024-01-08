package com;
import java.io.File;
 
public class UploadCon {
 
    // Windows, VMWare, AWS cloud 절대 경로 설정
    public static synchronized String getUploadDir() {
        String path = "";
        if (File.separator.equals("\\")) {
            path = "F:/ksnu/deploy/contents/storage/";
            System.out.println("Windows 10: " + path);
            
        } else {
            // System.out.println("Linux");
            path = "/home/ubuntu/deploy/contents/storage/";
        }
        
        return path;
    }
    
}