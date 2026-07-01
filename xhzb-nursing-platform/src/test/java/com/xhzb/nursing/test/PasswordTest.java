package com.xhzb.nursing.test;

import cn.hutool.crypto.digest.BCrypt;
import org.springframework.util.DigestUtils;

public class PasswordTest {

    public static void main(String[] args) {
        //md5   不可逆
//        String p1 = DigestUtils.md5DigestAsHex("12UUUddfd**&&..3456".getBytes());
////        String p2 = DigestUtils.md5DigestAsHex("123456".getBytes());
//        System.out.println(p1);
//        System.out.println(p2);



       /* String gensalt1 = BCrypt.gensalt();
        String password1 = BCrypt.hashpw("123456", gensalt1);

        String gensalt2 = BCrypt.gensalt();
        String password2 = BCrypt.hashpw("123456", gensalt2);
        System.out.println(password1);
        System.out.println(password2);*/

        boolean checkpw = BCrypt.checkpw("123456", "$2a$10$BhAb4AD.ud5.TXaZbP1QjuIyeMx5ooiV2utz1/J1dKUBmPZlDULS.");
        System.out.println(checkpw);
    }
}
