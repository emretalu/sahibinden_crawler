<?php

error_reporting(0);
header('Content-type: text/html; charset=utf8');
require 'sahibinden.class.php';

$db = new PDO("mysql:host=localhost;dbname=sahibinden_db;charset=utf8","sahibinden_user","password");

function insertSubCategory($db){
	$kontrol = $db->prepare("SELECT * FROM Category WHERE isActive = 'Y'");
	$kontrol->execute();
	
	if($kontrol->rowCount() > 0){
		foreach($kontrol->fetchAll() as $kategori){
			$alt_kategoriler = Sahibinden::Kategori($kategori["uri"]);
			
			foreach($alt_kategoriler as $alt_kategori){
				$query_sub = $db->prepare("INSERT INTO SubCategory(categoryId,name,uri,url) VALUES(:categoryId,:name,:altkategori_uri,:uri,:url)");
					
				$query_sub_return = $query_sub->execute(array(
					":categoryId" => $kategori["idCategory"],
					":name" => $alt_kategori["title"],
					":uri" =>$alt_kategori["uri"],
					":url" => $alt_kategori["url"]
				));
			}					
		}
	}
	echo "subcategory list crawled \n";
}

function insertSubCategory2($db){
	$kontrol_sub = $db->prepare("SELECT * FROM SubCategory WHERE isActive = 'Y'");
	$kontrol_sub->execute();
	
	if($kontrol_sub->rowCount() > 0){
		foreach($kontrol_sub->fetchAll() as $altkategori){
			$alt_kategoriler2 = Sahibinden::Kategori($altkategori["uri"]);
						
			foreach($alt_kategoriler2 as $alt_kategori2){
				$query_sub2 = $db->prepare("INSERT INTO SubCategory2(subCategoryId,name,uri,url) VALUES(:subCategoryId,:name,:uri,:url)");
				
				$query_sub_return2 = $query_sub2->execute(array(
					":subCategoryId" => $altkategori["idSubCategory"],
					":name" => $alt_kategori2["title"],
					":uri" => $alt_kategori2["uri"],
					":url" => $alt_kategori2["url"]
				));				
			}			
		}
	}
	echo "subcategory2 list crawled \n";
}

function insertSubCategory3($db){
	$kontrol_sub2 = $db->prepare("SELECT * FROM SubCategory2 WHERE isActive = 'Y'");
	$kontrol_sub2->execute();
	
	if($kontrol_sub2->rowCount() > 0){
		foreach($kontrol_sub2->fetchAll() as $altkategori2){
			$alt_kategoriler3 = Sahibinden::Kategori($altkategori2["uri"]);
						
			foreach($alt_kategoriler3 as $alt_kategori3){
				$query_sub3 = $db->prepare("INSERT INTO SubCategory3(subCategory2Id,name,uri,url) VALUES(:subCategory2Id,:name,:uri,:url)");
				
				$query_sub3_return = $query_sub3->execute(array(
					":subCategory2Id" => $altkategori2["idSubCategory2"],
					":name" => $alt_kategori3["title"],
					":uri" => $alt_kategori3["uri"],
					":url" => $alt_kategori3["url"]
				));				
			}			
		}
	}
	echo "subcategory3 list crawled \n";
}

function insertContent($db){
	$kontrol_sub3 = $db->prepare("SELECT * FROM SubCategory3 WHERE isActive = 'Y'");
	$kontrol_sub3->execute();
	
	if($kontrol_sub3->rowCount() > 0){
		foreach($kontrol_sub3->fetchAll() as $altkategori3){
			$content = Sahibinden::Liste($altkategori3["uri"]);
			
			foreach($content as $icerik){
				$query_content = $db->prepare("INSERT INTO Content(subCategory3Id,title,url) VALUES(:subCategory3Id,:title,:url)");
				
				$query_content_return = $query_content->execute(array(
					":subCategory3Id" => $altkategori3["idSubCategory3"],
					":title" => $icerik["title"],
					":url" => $icerik["url"]
				));
			}
		}
	}
	echo "contents crawled \n";
}

function insertDetails($db){
	$kontrol_content = $db->prepare("SELECT * FROM Content WHERE isActive = 'Y'");
	$kontrol_content->execute();
	
	if($kontrol_content->rowCount() > 0){
		foreach($kontrol_content->fetchAll() as $icerik){
			$detail = Sahibinden::Detay($icerik["url"]);
			
			foreach($detail as $detay){
				$query_detail = $db->prepare("INSERT INTO Detail(contentId,price,city,district,street,fromWhom,name,phone,mobile) VALUES(:contentId,:price,:city,:district,:street,:fromWhom,:name,:phone,:mobile)");
				
				$query_detail_return = $query_detail->execute(array(
					":contentId" => $icerik["idContent"],
					":price" => $detay["price"],
					":city" => $detay["address"]["il"],
					":district" => $detay["address"]["ilce"],
					":street" => $detay["address"]["mahalle"],
					":fromWhom" => $detay["properties"]["Kimden"],
					":name" => $detay["user"]["name"],
					":phone" => $detay["user"]["contact"],
					":mobile" => $detay["user"]["contact_mobile"]
				));
			}
		}
	}
	echo "details crawled \n";
}

echo insertSubCategory($db) . "\n";