-- MySQL dump 10.13  Distrib 8.4.8, for Linux (x86_64)
--
-- Host: localhost    Database: lumiere
-- ------------------------------------------------------
-- Server version	8.4.8-0ubuntu1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carrinho`
--

DROP TABLE IF EXISTS `carrinho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrinho` (
  `id` int NOT NULL AUTO_INCREMENT,
    `usuario_id` int DEFAULT NULL,
      `produto_id` int DEFAULT NULL,
        `quantidade` int DEFAULT '1',
          PRIMARY KEY (`id`),
            KEY `usuario_id` (`usuario_id`),
              KEY `produto_id` (`produto_id`),
                CONSTRAINT `carrinho_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
                  CONSTRAINT `carrinho_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
                  ) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
                  /*!40101 SET character_set_client = @saved_cs_client */;

                  --
                  -- Dumping data for table `carrinho`
                  --

                  LOCK TABLES `carrinho` WRITE;
                  /*!40000 ALTER TABLE `carrinho` DISABLE KEYS */;
                  /*!40000 ALTER TABLE `carrinho` ENABLE KEYS */;
                  UNLOCK TABLES;

                  --
                  -- Table structure for table `itens_pedido`
                  --

                  DROP TABLE IF EXISTS `itens_pedido`;
                  /*!40101 SET @saved_cs_client     = @@character_set_client */;
                  /*!50503 SET character_set_client = utf8mb4 */;
                  CREATE TABLE `itens_pedido` (
                    `id` int NOT NULL AUTO_INCREMENT,
                      `pedido_id` int DEFAULT NULL,
                        `produto_id` int DEFAULT NULL,
                          `quantidade` int DEFAULT NULL,
                            `preco` decimal(10,2) DEFAULT NULL,
                              PRIMARY KEY (`id`),
                                KEY `pedido_id` (`pedido_id`),
                                  KEY `produto_id` (`produto_id`),
                                    CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
                                      CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
                                      ) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
                                      /*!40101 SET character_set_client = @saved_cs_client */;

                                      --
                                      -- Dumping data for table `itens_pedido`
                                      --

                                      LOCK TABLES `itens_pedido` WRITE;
                                      /*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
                                      INSERT INTO `itens_pedido` VALUES (1,1,19,1,999.90),(2,1,24,2,999.90),(3,1,2,1,699.90),(4,2,2,1,699.90),(5,3,2,2,699.90),(6,3,8,1,299.90),(7,4,50,2,429.90),(8,5,2,1,699.90),(9,6,2,2,699.90),(10,7,6,1,899.90),(11,8,50,1,429.90),(12,9,5,1,699.90),(13,10,2,2,699.90),(14,10,56,1,4999.90),(15,11,2,1,699.90);
                                      /*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
                                      UNLOCK TABLES;

                                      --
                                      -- Table structure for table `pedidos`
                                      --

                                      DROP TABLE IF EXISTS `pedidos`;
                                      /*!40101 SET @saved_cs_client     = @@character_set_client */;
                                      /*!50503 SET character_set_client = utf8mb4 */;
                                      CREATE TABLE `pedidos` (
                                        `id` int NOT NULL AUTO_INCREMENT,
                                          `usuario_id` int DEFAULT NULL,
                                            `data_pedido` datetime DEFAULT CURRENT_TIMESTAMP,
                                              `total` decimal(10,2) DEFAULT NULL,
                                                PRIMARY KEY (`id`),
                                                  KEY `usuario_id` (`usuario_id`),
                                                    CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
                                                    ) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
                                                    /*!40101 SET character_set_client = @saved_cs_client */;

                                                    --
                                                    -- Dumping data for table `pedidos`
                                                    --

                                                    LOCK TABLES `pedidos` WRITE;
                                                    /*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
                                                    INSERT INTO `pedidos` VALUES (1,2,'2026-06-01 14:44:24',3699.60),(2,2,'2026-06-01 14:46:38',699.90),(3,2,'2026-06-01 14:49:50',1699.70),(4,2,'2026-06-01 15:05:24',859.80),(5,2,'2026-06-01 15:05:46',699.90),(6,2,'2026-06-01 15:10:45',1399.80),(7,2,'2026-06-01 15:15:33',899.90),(8,2,'2026-06-02 13:14:50',429.90),(9,3,'2026-06-02 13:58:03',699.90),(10,3,'2026-06-02 14:10:01',6399.70),(11,2,'2026-06-02 14:18:40',699.90);
                                                    /*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
                                                    UNLOCK TABLES;

                                                    --
                                                    -- Table structure for table `produtos`
                                                    --

                                                    DROP TABLE IF EXISTS `produtos`;
                                                    /*!40101 SET @saved_cs_client     = @@character_set_client */;
                                                    /*!50503 SET character_set_client = utf8mb4 */;
                                                    CREATE TABLE `produtos` (
                                                      `id` int NOT NULL AUTO_INCREMENT,
                                                        `nome` varchar(255) NOT NULL,
                                                          `descricao` text,
                                                            `preco` decimal(10,2) DEFAULT NULL,
                                                              `imagem` varchar(255) DEFAULT NULL,
                                                                `categoria` varchar(100) DEFAULT NULL,
                                                                  PRIMARY KEY (`id`)
                                                                  ) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
                                                                  /*!40101 SET character_set_client = @saved_cs_client */;

                                                                  --
                                                                  -- Dumping data for table `produtos`
                                                                  --

                                                                  LOCK TABLES `produtos` WRITE;
                                                                  /*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
                                                                  INSERT INTO `produtos` VALUES (1,'Bolsa 1','Bolsa lisa',599.90,'imagens/bolsas/bolsa_1.png','bolsas'),(2,'Bolsa 2','Bolsa texturizada',699.90,'imagens/bolsas/bolsa_2.png','bolsas'),(3,'Bolsa 3','Bolsa de alça',499.90,'imagens/bolsas/bolsa_3.png','bolsas'),(4,'Bolsa 4','Bolsa sacola',799.90,'imagens/bolsas/bolsa_4.png','bolsas'),(5,'Bolsa 5','Bolsa de mão',699.90,'imagens/bolsas/bolsa_5.png','bolsas'),(6,'Bolsa 6','Bolsa cruzada',899.90,'imagens/bolsas/bolsa_6.png','bolsas'),(7,'Calça 1','Calça jeans',199.90,'imagens/calcas/calca_1.png','calcas'),(8,'Calça 2','Calça cinza',299.90,'imagens/calcas/calca_2.png','calcas'),(9,'Calça 3','Calça jeans marrom',399.90,'imagens/calcas/calca_3.png','calcas'),(10,'Calça 4','Calça preta',299.90,'imagens/calcas/calca_4.png','calcas'),(11,'Calça 5','Calça marrom veludo',199.90,'imagens/calcas/calca_5.png','calcas'),(12,'Calça 6','Calça verde',299.90,'imagens/calcas/calca_6.png','calcas'),(13,'Camisa 1','Camisa bege',199.90,'imagens/camisas/camisa_1.png','camisas'),(14,'Camisa 2','Camisa azul',199.90,'imagens/camisas/camisa_2.png','camisas'),(15,'Camisa 3','Camisa preta de botão',399.90,'imagens/camisas/camisa_3.png','camisas'),(16,'Camisa 4','Camisa verde',199.90,'imagens/camisas/camisa_4.png','camisas'),(17,'Camisa 5','Camisa cinza',199.90,'imagens/camisas/camisa_5.png','camisas'),(18,'Camisa 6','Camisa preta elegante',299.90,'imagens/camisas/camisa_6.png','camisas'),(19,'Casaco 1','Casaco bege',999.90,'imagens/casacos/casaco_1.png','casacos'),(20,'Casaco 2','Casaco verde',899.90,'imagens/casacos/casaco_2.png','casacos'),(21,'Casaco 3','Casaco de couro',1099.90,'imagens/casacos/casaco_3.png','casacos'),(22,'Casaco 4','Casaco cinza',899.90,'imagens/casacos/casaco_4.png','casacos'),(23,'Casaco 5','Casaco jeans',799.90,'imagens/casacos/casaco_5.png','casacos'),(24,'Casaco 6','Casaco puffer',999.90,'imagens/casacos/casaco_6.png','casacos'),(25,'Sapato 1','Sapato preto',499.90,'imagens/sapatos/sapato_1.png','sapatos'),(26,'Sapato 2','Sapato bege',599.90,'imagens/sapatos/sapato_2.png','sapatos'),(27,'Sapato 3','Sapato peep toe',399.90,'imagens/sapatos/sapato_3.png','sapatos'),(28,'Sapato 4','Sapato bota',699.90,'imagens/sapatos/sapato_4.png','sapatos'),(29,'Sapato 5','Sapato dourado',599.90,'imagens/sapatos/sapato_5.png','sapatos'),(30,'Sapato 6','Sapato transparente',599.90,'imagens/sapatos/sapato_6.png','sapatos'),(31,'Chapéu 1','Chapéu clássico',149.90,'imagens/chapeus/chapeu_1.png','chapeus'),(32,'Chapéu 2','Boina marrom',249.90,'imagens/chapeus/chapeu_2.png','chapeus'),(33,'Chapéu 3','Touca cinza',49.90,'imagens/chapeus/chapeu_3.png','chapeus'),(34,'Chapéu 4','Boina listrada',249.90,'imagens/chapeus/chapeu_4.png','chapeus'),(35,'Chapéu 5','Boina de couro',349.90,'imagens/chapeus/chapeu_5.png','chapeus'),(36,'Chapéu 6','Boina cinza',249.90,'imagens/chapeus/chapeu_6.png','chapeus'),(37,'Pijama 1','Pijama preto',249.90,'imagens/pijamas/pijama_1.png','pijamas'),(38,'Pijama 2','Pijama azul',349.90,'imagens/pijamas/pijama_2.png','pijamas'),(39,'Pijama 3','Pijama cinza',349.90,'imagens/pijamas/pijama_3.png','pijamas'),(40,'Pijama 4','Pijama veludo',449.90,'imagens/pijamas/pijama_4.png','pijamas'),(41,'Pijama 5','Pijama branco',349.90,'imagens/pijamas/pijama_5.png','pijamas'),(42,'Pijama 6','Pijama listrado',249.90,'imagens/pijamas/pijama_6.png','pijamas'),(43,'Cinto 1','Cinto preto',179.90,'imagens/cintos/cinto_1.png','cintos'),(44,'Cinto 2','Cinto marrom',279.90,'imagens/cintos/cinto_2.png','cintos'),(45,'Cinto 3','Cinto de lenço estampado',79.90,'imagens/cintos/cinto_3.png','cintos'),(46,'Cinto 4','Cinto texturizado',379.90,'imagens/cintos/cinto_4.png','cintos'),(47,'Cinto 5','Cinto de lenço liso',79.90,'imagens/cintos/cinto_5.png','cintos'),(48,'Cinto 6','Cinto textura bolinhas',279.90,'imagens/cintos/cinto_6.png','cintos'),(49,'Maquiagem 1','Blush',129.90,'imagens/maquiagens/maquiagem_1.png','maquiagens'),(50,'Maquiagem 2','Sombra',429.90,'imagens/maquiagens/maquiagem_2.png','maquiagens'),(51,'Maquiagem 3','Rímel',229.90,'imagens/maquiagens/maquiagem_3.png','maquiagens'),(52,'Maquiagem 4','Pincel',229.90,'imagens/maquiagens/maquiagem_4.png','maquiagens'),(53,'Maquiagem 5','Base',329.90,'imagens/maquiagens/maquiagem_5.png','maquiagens'),(54,'Maquiagem 6','Corretivo',229.90,'imagens/maquiagens/maquiagem_6.png','maquiagens'),(55,'Joia 1','Brincos de argola prata',999.90,'imagens/joias/joia_1.png','joias'),(56,'Joia 2','Alianças douradas',4999.90,'imagens/joias/joia_2.png','joias'),(57,'Joia 3','Pulseira prata',1999.90,'imagens/joias/joia_3.png','joias'),(58,'Joia 4','Pulseira dourada',2999.90,'imagens/joias/joia_4.png','joias'),(59,'Joia 5','Anel prata',1999.90,'imagens/joias/joia_5.png','joias'),(60,'Joia 6','Brinco dourado',2999.90,'imagens/joias/joia_6.png','joias');
                                                                  /*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
                                                                  UNLOCK TABLES;

                                                                  --
                                                                  -- Table structure for table `usuarios`
                                                                  --

                                                                  DROP TABLE IF EXISTS `usuarios`;
                                                                  /*!40101 SET @saved_cs_client     = @@character_set_client */;
                                                                  /*!50503 SET character_set_client = utf8mb4 */;
                                                                  CREATE TABLE `usuarios` (
                                                                    `id` int NOT NULL AUTO_INCREMENT,
                                                                      `nome` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                                                        `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                                                          `senha` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                                                            PRIMARY KEY (`id`),
                                                                              UNIQUE KEY `email` (`email`)
                                                                              ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
                                                                              /*!40101 SET character_set_client = @saved_cs_client */;

                                                                              --
                                                                              -- Dumping data for table `usuarios`
                                                                              --

                                                                              LOCK TABLES `usuarios` WRITE;
                                                                              /*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
                                                                              INSERT INTO `usuarios` VALUES (1,'Marina','marina@gmail.com','marina'),(2,'Pamela','pamela@gmail.com','scrypt:32768:8:1$gUEl6VTerEvEwGPi$76376f37f754d1d0b23a0cc18a9eba5f6b67c9a6a56267951fc8f9a8680773a59a8681f43538d8fcf2c0d9fa194e097889437c3b4897c0f155e258c12d62ef03'),(3,'Maria','maria@gmail.com','scrypt:32768:8:1$cGzXEscLsHuWsctu$710d6e1e7ed9e9f71bb63dff079d57a7c49d760749a5b0d1afae5af6aa30deb77d71bf8303e5f9aecadf3f39ec7779f44fa9dac7b79a362af0d1b9378d6f0c86');
                                                                              /*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
                                                                              UNLOCK TABLES;
                                                                              /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

                                                                              /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
                                                                              /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
                                                                              /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
                                                                              /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
                                                                              /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
                                                                              /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
                                                                              /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

                                                                              -- Dump completed on 2026-06-02 14:42:57
                                                                              