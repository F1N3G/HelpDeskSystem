# STEP 1 - Script Instalare
# Ruleaza: .\install-step1.ps1

Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host "STEP 1: Instalare Laravel Breeze Bootstrap - HelpDesk IT" -ForegroundColor Cyan
Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host ""

$env:Path = "C:\laragon\bin\php\php-8.3.8-Win32-vs16-x64;" + $env:Path
$composerPath = "C:\laragon\bin\composer\composer.phar"

function Invoke-Composer {
    php $composerPath $args
}

Write-Host "[1/9] Verificare PHP..." -ForegroundColor Yellow
php --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "EROARE: PHP nu este disponibil!" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] PHP OK" -ForegroundColor Green
Write-Host ""

Write-Host "[2/9] Verificare Composer..." -ForegroundColor Yellow
Invoke-Composer --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "EROARE: Composer nu este disponibil!" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Composer OK" -ForegroundColor Green
Write-Host ""

Write-Host "[3/9] Instalare Laravel 11..." -ForegroundColor Yellow
Write-Host "Aceasta dureaza cateva minute..." -ForegroundColor Gray
Invoke-Composer create-project laravel/laravel temp "^11.0" --prefer-dist
if ($LASTEXITCODE -ne 0) {
    Write-Host "EROARE la instalarea Laravel!" -ForegroundColor Red
    exit 1
}

Write-Host "Mutare fisiere..." -ForegroundColor Gray
Get-ChildItem -Path "temp" | Move-Item -Destination "." -Force
Remove-Item "temp" -Recurse -Force
Write-Host "[OK] Laravel instalat" -ForegroundColor Green
Write-Host ""

Write-Host "[4/9] Generare APP_KEY..." -ForegroundColor Yellow
php artisan key:generate
Write-Host "[OK] APP_KEY generat" -ForegroundColor Green
Write-Host ""

Write-Host "[5/9] Configurare .env..." -ForegroundColor Yellow
$envContent = Get-Content ".env" -Raw
$envContent = $envContent -replace 'APP_NAME=Laravel', 'APP_NAME="HelpDesk IT"'
$envContent = $envContent -replace 'DB_DATABASE=laravel', 'DB_DATABASE=helpdesk_it'
Set-Content ".env" $envContent
Write-Host "[OK] .env configurat" -ForegroundColor Green
Write-Host ""

Write-Host "[6/9] Creare baza de date..." -ForegroundColor Yellow
$mysqlPath = "C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysql.exe"
if (Test-Path $mysqlPath) {
    & $mysqlPath -u root -e "CREATE DATABASE IF NOT EXISTS helpdesk_it CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    Write-Host "[OK] Baza de date creata" -ForegroundColor Green
} else {
    Write-Host "[WARN] MySQL nu a fost gasit. Creeaza manual baza 'helpdesk_it' din HeidiSQL" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "[7/9] Instalare Laravel Breeze..." -ForegroundColor Yellow
Invoke-Composer require laravel/breeze --dev
php artisan breeze:install blade --no-interaction
php artisan migrate --force
Write-Host "[OK] Breeze instalat" -ForegroundColor Green
Write-Host ""

Write-Host "[8/9] Instalare npm packages..." -ForegroundColor Yellow
if (Get-Command npm -ErrorAction SilentlyContinue) {
    npm install
    npm install bootstrap @popperjs/core
    Write-Host "[OK] npm packages instalate" -ForegroundColor Green
} else {
    Write-Host "[WARN] npm nu este disponibil. Ruleaza manual:" -ForegroundColor Yellow
    Write-Host "  npm install" -ForegroundColor Gray
    Write-Host "  npm install bootstrap @popperjs/core" -ForegroundColor Gray
}
Write-Host ""

Write-Host "[9/9] Creare HomeController..." -ForegroundColor Yellow
php artisan make:controller HomeController
Write-Host "[OK] HomeController creat" -ForegroundColor Green
Write-Host ""

Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host "INSTALARE COMPLETA!" -ForegroundColor Green
Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "PASII URMATORI:" -ForegroundColor Yellow
Write-Host "1. Ruleaza: npm run build" -ForegroundColor White
Write-Host "2. Anunta-ma pentru a crea fisierele de cod" -ForegroundColor White
Write-Host "3. Ruleaza: php artisan serve" -ForegroundColor White
Write-Host "4. Acceseaza: http://localhost:8000" -ForegroundColor White
Write-Host ""

