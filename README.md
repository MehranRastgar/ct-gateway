# 🚪 API Gateway

Gateway مرکزی برای دسترسی به تمام سرویس‌های فیت‌هاب

## 📝 توضیحات

این Gateway با استفاده از Ocelot پیاده‌سازی شده و به عنوان یک نقطه ورودی واحد برای تمام سرویس‌های فیت‌هاب عمل می‌کند. این Gateway مسیریابی درخواست‌ها به سرویس‌های مختلف را انجام می‌دهد و همچنین مسئول مدیریت CORS و احراز هویت است.

## 🛠️ تکنولوژی‌ها

- ASP.NET Core 8
- Ocelot
- Docker
- Docker Compose

## 📋 پیش‌نیازها

- Docker
- Docker Compose
- .NET 8 SDK (برای توسعه)

## 🚀 راه‌اندازی پروژه

### روش 1: استفاده از Docker Compose

1. کلون کردن پروژه:

```bash
git clone https://github.com/MehranRastgar/fithub-microservices.git
cd fithub-microservices/gateway
```

2. اجرای اسکریپت ساخت و اجرا:

```bash
chmod +x build-and-run.sh
./build-and-run.sh
```

### روش 2: اجرای دستی

1. ساخت تصاویر Docker:

```bash
# ساخت تصویر Identity Service
cd ../IdentityService
docker build -t identity-service:latest .

# ساخت تصویر Workout Service
cd ../WorkoutService
docker build -t workout-service:latest .

# برگشت به پوشه Gateway
cd ../gateway
```

2. اجرای سرویس‌ها با Docker Compose:

```bash
docker-compose up -d
```

## 🔄 مسیرهای API

### Identity Service

- `GET /api/auth/{everything}` - دسترسی به API‌های احراز هویت
- `GET /api/User/{everything}` - دسترسی به API‌های کاربر

### Workout Service

- `GET /api/WorkoutProgram/{everything}` - دسترسی به API‌های برنامه تمرینی
- `GET /api/WorkoutProgramGenerator/{everything}` - دسترسی به API‌های تولید برنامه تمرینی
- `GET /api/ExerciseType/{everything}` - دسترسی به API‌های نوع تمرین

## 🔒 امنیت

- تمام درخواست‌ها از طریق Gateway عبور می‌کنند
- احراز هویت با JWT
- مدیریت CORS برای دسترسی از دامنه‌های مجاز

## 🔜 برنامه‌های آینده

- [ ] اضافه کردن Rate Limiting
- [ ] اضافه کردن Caching
- [ ] اضافه کردن Load Balancing
- [ ] اضافه کردن Circuit Breaker
- [ ] اضافه کردن Monitoring و Logging

## 📄 لایسنس

این پروژه تحت لایسنس [MIT](LICENSE) منتشر شده است.
