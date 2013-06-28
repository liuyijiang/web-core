package com.mxk.org;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class Snippet {
    /**
     * ����ͼƬ����ͼ(�ȱ�����)
     * 
     * @param src
     *            ԴͼƬ�ļ�����·��
     * @param dist
     *            Ŀ��ͼƬ�ļ�����·��
     * @param width
     *            ���ŵĿ��
     * @param height
     *            ���ŵĸ߶�
     */
    public static void createThumbnail(String src, String dist, float width,
            float height) {
        try {
            File srcfile = new File(src);
            if (!srcfile.exists()) {
                System.out.println("�ļ�������");
                return;
            }
            BufferedImage image = ImageIO.read(srcfile);

            // ������ŵı���
            double ratio = 1.0;
            // �ж�����ߡ����������趨ֵ���򲻴���
            if (image.getHeight() > height || image.getWidth() > width) {
                if (image.getHeight() > image.getWidth()) {
                    ratio = height / image.getHeight();
                } else {
                    ratio = width / image.getWidth();
                }
            }
            // �����µ�ͼ���Ⱥ͸߶�
            int newWidth = (int) (image.getWidth() * 0.5);
            int newHeight = (int) (image.getHeight() * 0.5);

            BufferedImage bfImage = new BufferedImage(newWidth, newHeight,
                    BufferedImage.TYPE_INT_RGB);
            bfImage.getGraphics().drawImage(
                    image.getScaledInstance(newWidth, newHeight,
                            Image.SCALE_SMOOTH), 0, 0, null);

            FileOutputStream os = new FileOutputStream(dist);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
            encoder.encode(bfImage);
            os.close();
            System.out.println("��������ͼ�ɹ�");
        } catch (Exception e) {
            System.out.println("��������ͼ�����쳣" + e.getMessage());
        }
    }
    
    public static void main(String[] args) {
        createThumbnail("F:\\ship\\����ɯ��-����\\����ɹ�\\2.JPG", "D:\\a2.png", 800, 600);
//        createThumbnail("E:\\1.jpg", "D:\\b.png", 2000, 2000);
//        createThumbnail("E:\\1.jpg", "D:\\c.jpg", 800, 600);
    }

}