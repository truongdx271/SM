/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Char;

import java.util.Random;

/**
 *
 * @author daotao02
 */
public class CharControl {

    public String randomString(int size) {

        String str01 = "abcdefghijklmnopqrstuvwxyz";
        String str02 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String str03 = "0123456789";

        // These are the valid charecters use to random.
        // Đây là các ký tự được dùng để chuỗi ký tự ngẫu nhiên.
        String strValid = str01 + str02 + str03;

        Random random = new Random();

        String mystring = "";
        for (int i = 0; i < size; i++) {
            int randnum = random.nextInt(strValid.length());
            mystring = mystring + strValid.charAt(randnum);
        }
        return mystring;
    }
}
