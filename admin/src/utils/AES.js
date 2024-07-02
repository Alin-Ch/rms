import CryptoJS from 'crypto-js';

const aesEncrypt = (message, secret) => {
    const encrypted = CryptoJS.AES.encrypt(message, secret);
    return encrypted.toString();
};

const aesDecrypt = (encryptedMessage, secret) => {
    const decrypted = CryptoJS.AES.decrypt(encryptedMessage, secret);
    return decrypted.toString(CryptoJS.enc.Utf8);
};

export { aesEncrypt, aesDecrypt };
