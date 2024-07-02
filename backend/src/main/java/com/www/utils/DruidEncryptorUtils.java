package com.www.utils;

import com.alibaba.druid.filter.config.ConfigTools;
import lombok.SneakyThrows;

import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;

/**
 * alibaba druid加解密规则：
 * 明文密码+私钥(privateKey)加密=加密密码
 * 加密密码+公钥(publicKey)解密=明文密码
 */
public final class DruidEncryptorUtils {

    private static String privateKey;

    private static String publicKey;

    static {
        try {
            String[] keyPair = ConfigTools.genKeyPair(512);
            privateKey = keyPair[0];
            System.out.println(String.format("privateKey-->%s", privateKey));
            publicKey = keyPair[1];
            System.out.println(String.format("publicKey-->%s", publicKey));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchProviderException e) {
            e.printStackTrace();
        }
    }

    /**
     * 明文加密
     *
     * @param plaintext
     * @return
     */
    @SneakyThrows
    public static String encode(String plaintext) {
        System.out.println("明文字符串：" + plaintext);
        String ciphertext = ConfigTools.encrypt(privateKey, plaintext);
        System.out.println("加密后字符串：" + ciphertext);
        return ciphertext;
    }

    /**
     * 解密
     *
     * @param ciphertext
     * @return
     */
    @SneakyThrows
    public static String decode(String ciphertext) {
        System.out.println("加密字符串：" + ciphertext);
        String plaintext = ConfigTools.decrypt(publicKey, ciphertext);
        System.out.println("解密后的字符串：" + plaintext);

        return plaintext;
    }

    // 运行main函数得出密钥和密文
    public static void main(String[] args) {
        String encode = DruidEncryptorUtils.encode("123456");
        System.out.println("encode = " + encode);
    }
}


