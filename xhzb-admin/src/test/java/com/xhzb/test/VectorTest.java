package com.xhzb.test;

import org.junit.jupiter.api.Test;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class VectorTest {

    @Autowired
    private VectorStore vectorStore;

    @Test
    public void test(){

        List<Document> documents = new ArrayList<>();
        Document doc1 = new Document("延庆区位于北京西北部，以山地为主（山区占72.8%），拥有海陀山等自然景观，空气质量优异（2025年7月AQI达优级），是北京市生态涵养核心区。" );
        Document doc2 = new Document("北京八达岭长城是世界文化遗产，明代长城最精华段，素有“北门锁钥”之称，是万里长城的重要关隘与代表性景观。" );
        documents.add(doc1);
        documents.add(doc2);

        vectorStore.add(documents);
    }
}
