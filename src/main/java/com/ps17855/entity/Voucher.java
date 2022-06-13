package com.ps17855.entity;

import java.io.Serializable;
import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity 
@Table(name = "Voucher")
public class Voucher implements Serializable {
	@Id
	@Column(name = "Id")
	private String id;
	
	@Column(name = "Content")
	private String content;
	
	@Column(name = "Discount")
	private double discount;
	
	@DateTimeFormat(iso = ISO.DATE)
	@Column(name = "Start")
	private LocalDate start;
	
	@DateTimeFormat(iso = ISO.DATE)
	@Column(name = "`End`")
	private LocalDate end;
}
