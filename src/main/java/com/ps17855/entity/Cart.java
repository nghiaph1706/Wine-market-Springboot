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
@Table(name = "Cart")
public class Cart implements Serializable {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "CartId")
	private int id;
	
	@ManyToOne @JoinColumn(name = "UserId")
	User user;
	
	@ManyToOne @JoinColumn(name = "ProductId")
	Product product;
	
	@Column(name = "Quantity")
	private int quantity;
	
	@Column(name = "Hide")
	private boolean hide;
}
