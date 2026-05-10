
<div align="center">

# ⚙️ FANDM — Backend
### Food and Stock of Order Management

> REST API untuk sistem manajemen order dan stok usaha makanan — dibangun dengan pendekatan enterprise-grade dan siap migrasi ke SaaS multi-tenant.

![Spring Boot](https://img.shields.io/badge/Spring_Boot-Java-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Status](https://img.shields.io/badge/Status-Phase_1-yellow?style=for-the-badge)

<br/>

Bagian dari proyek **FANDM** · Dikembangkan oleh **Tentic Studio**

</div>

---

## 🛠️ Tech Stack

| Kategori | Teknologi |
| :--- | :--- |
| ☕ **Framework** | Java Spring Boot |
| 🔐 **Auth** | Spring Security + JWT |
| 🗄️ **Database** | PostgreSQL + Spring Data JPA (Hibernate) |
| 🔄 **Migration** | Flyway |
| ⚡ **Caching** | Redis |
| 📄 **API Docs** | OpenAPI / Swagger |
| 📦 **Build Tool** | Maven |
| 🐳 **Infrastructure** | Docker + Docker Compose |

---

## 📦 Instalasi

**Prasyarat:** Java 21+, Maven, Docker

```bash
# Clone repositori
git clone https://github.com/Tentic-Studio/TNC-fendm-be.git
cd TNC-fendm-be

# Salin konfigurasi environment
cp .env.example .env
# Sesuaikan nilai di .env (DB, Redis, JWT secret)

# Jalankan PostgreSQL & Redis via Docker
docker compose up -d

# Jalankan aplikasi
./mvnw spring-boot:run
```

> API berjalan di `http://localhost:8080`. Dokumentasi Swagger tersedia di `/swagger-ui.html`.

---

## 📂 Struktur Package

```
src/main/java/com/tentic/fandm/
├── config/         # Konfigurasi Spring Security, CORS, dll
├── controller/     # REST API endpoint
├── service/        # Business logic & integrasi otomatis
├── repository/     # Spring Data JPA repository
├── entity/         # JPA entity (tabel database)
├── dto/            # Request & Response DTO
└── mapper/         # MapStruct mapper (DTO <-> Entity) (Optional)
```

---

## 🔗 Modul API

| Modul | Endpoint Prefix |
| :--- | :--- |
| 🔐 Auth | `/api/auth` |
| 📦 Bahan Baku | `/api/ingredients` |
| 🍰 Produk & Resep | `/api/products` |
| 🛒 Order | `/api/orders` |
| ⚙️ Produksi | `/api/productions` |
| 💰 Cash Flow | `/api/cash-flows` |

---

## ⚡ Proses Otomatis

Beberapa aksi memicu proses otomatis di sisi backend:

- **Pembayaran order** → Otomatis buat record *cash flow* pemasukan
- **Pembelian bahan baku** → Otomatis catat pengeluaran & perbarui rata-rata harga beli
- **Order selesai** *(Made to Order)* → Otomatis kurangi stok bahan baku
- **Produksi berhasil** → Otomatis tambah stok produk jadi
- **Resep diperbarui** → Otomatis simpan versi baru & nonaktifkan resep lama

---

<div align="center">

**© 2025 Tentic Studio** · [Frontend Repo](https://github.com/Tentic-Studio/TNC-fendm-fe.git)

</div>