package com.ps17855.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ps17855.entity.Voucher;

public interface VoucherDAO extends JpaRepository<Voucher, String> {

}
