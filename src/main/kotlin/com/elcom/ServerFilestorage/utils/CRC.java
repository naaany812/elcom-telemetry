package com.elcom.ServerFilestorage.utils;

public class CRC {
    public byte crc8(byte[] data, int offset, int end){
        byte crc = (byte)0xFF;
        for(int num = offset; num < end; ++num){
            crc ^= data[num];
            for(int i = 0; i < 8; i++){
                crc = (byte)((crc & 0x80) != 0 ? (crc << 1) ^ 0x31 : crc << 1);
            }
        }
        return crc;
    }
}
