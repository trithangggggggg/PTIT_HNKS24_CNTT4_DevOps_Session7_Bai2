#!/bin/bash
# Script cau hinh UFW cho Cum Dich vu Multi-port (Bai 2)

echo "[1/4] Thiet lap chinh sach mac dinh..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "[2/4] Mo cac cong can thiet..."
sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 80/tcp comment 'Nginx HTTP'
sudo ufw allow 8082/tcp comment 'Spring Boot'
# Luu y: Cong 3306 (MySQL) khong mo rule allow -> mac dinh bi chan tu Internet

echo "[3/4] Kich hoat UFW..."
sudo ufw --force enable

echo "[4/4] Kiem tra trang thai UFW chi tiet..."
sudo ufw status verbose
