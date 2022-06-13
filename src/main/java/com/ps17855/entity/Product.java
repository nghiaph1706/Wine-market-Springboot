package com.ps17855.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity 
@Table(name = "Product")
public class Product implements Serializable{

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ProductId")
	private int id;
	@Column(name = "Name")
	private String name;
	@Column(name = "Image")
	private String image;
	@Column(name = "Price")
	private double price;
	
	@ManyToOne @JoinColumn(name = "CategoryId")
	Category category;
	
	@ManyToOne @JoinColumn(name = "BrandId")
	Brand brand;
}
