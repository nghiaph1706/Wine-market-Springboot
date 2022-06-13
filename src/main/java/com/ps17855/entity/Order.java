package com.ps17855.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;
import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity 
@Table(name = "`Order`")
public class Order implements Serializable {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "OrderId")
	private int id;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(name = "DateOrder")
	private Date dateOrder = new Date();
	
	@Column(name = "Total")
	private double total;
	
	@Column(name = "Status")
	private String status;
	
	@Column(name = "Hide")
	private boolean hide;
	
	@ManyToOne @JoinColumn(name = "UserId")
	User user;
}
