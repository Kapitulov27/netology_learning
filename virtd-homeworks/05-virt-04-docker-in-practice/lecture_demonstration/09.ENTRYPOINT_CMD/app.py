import signal
import sys
import time
import random
from datetime import datetime

# Глобальная переменная для graceful shutdown
shutdown_requested = False
current_transaction = None

def sigterm_handler(signum, frame):
    """Обработчик SIGTERM - graceful shutdown"""
    global shutdown_requested
    print("\n" + "="*70)
    print("⚠️  SIGTERM получен! Инициирую безопасное завершение...")
    print("="*70)
    shutdown_requested = True

# Регистрируем обработчик SIGTERM
signal.signal(signal.SIGTERM, sigterm_handler)

def process_transaction(tx_id, amount, account_from, account_to):
    """Симуляция обработки финансовой транзакции"""
    global current_transaction, shutdown_requested
    
    current_transaction = {
        'id': tx_id,
        'amount': amount,
        'from': account_from,
        'to': account_to
    }
    
    print(f"\n{'─'*70}")
    print(f"💰 Транзакция #{tx_id:04d}")
    print(f"   Со счета: {account_from}")
    print(f"   На счет:  {account_to}")
    print(f"   Сумма:    ${amount:,.2f}")
    print(f"{'─'*70}")
    
    steps = [
        ("Проверка баланса отправителя", 1),
        ("Блокировка средств", 1),
        ("Проверка лимитов и KYC", 1.5),
        ("Инициация перевода", 1),
        ("Подтверждение получателем", 1.5),
        ("Списание со счета отправителя", 1),
        ("Зачисление на счет получателя", 1),
        ("Обновление балансов", 0.5),
        ("Формирование отчета", 0.5),
        ("Уведомление пользователей", 0.5)
    ]
    
    for i, (step, duration) in enumerate(steps, 1):
        if shutdown_requested:
            print(f"\n{'='*70}")
            print(f"⏸️  ОТКАТ ТРАНЗАКЦИИ #{tx_id:04d}")
            print(f"   Шаг {i-1}/{len(steps)} был завершен")
            print(f"   Выполняю безопасный откат изменений...")
            print(f"{'='*70}")
            time.sleep(0.5)
            print(f"✅ Средства разблокированы")
            print(f"✅ Транзакция отменена корректно")
            print(f"✅ Данные согласованы")
            return False
        
        print(f"   [{i:2d}/{len(steps)}] {step}...", end='', flush=True)
        time.sleep(duration)
        print(" ✓")
    
    print(f"\n✅ Транзакция #{tx_id:04d} успешно завершена!")
    print(f"   Баланс обновлен в БД")
    current_transaction = None
    return True

def main():
    print("╔" + "═"*68 + "╗")
    print("║" + " "*15 + "💳 ФИНАНСОВАЯ СИСТЕМА v2.0" + " "*27 + "║")
    print("╚" + "═"*68 + "╝")
    print()
    print(f"🚀 Система запущена: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"📊 PID: {os.getpid() if 'os' in dir() else 'N/A'}")
    print(f"🔒 SIGTERM обработчик зарегистрирован")
    print()
    
    accounts = [
        "ACC-US-001234", "ACC-UK-005678", "ACC-EU-009012",
        "ACC-JP-003456", "ACC-CN-007890", "ACC-DE-001122"
    ]
    
    tx_id = 1
    completed = 0
    failed = 0
    
    while not shutdown_requested:
        amount = random.uniform(100, 50000)
        acc_from = random.choice(accounts)
        acc_to = random.choice([a for a in accounts if a != acc_from])
        
        success = process_transaction(tx_id, amount, acc_from, acc_to)
        
        if success:
            completed += 1
        else:
            failed += 1
            break
        
        tx_id += 1
        
        if not shutdown_requested:
            time.sleep(random.uniform(0.5, 1.5))
    
    # Graceful shutdown
    print("\n" + "╔" + "═"*68 + "╗")
    print("║" + " "*20 + "БЕЗОПАСНОЕ ЗАВЕРШЕНИЕ РАБОТЫ" + " "*20 + "║")
    print("╚" + "═"*68 + "╝")
    print()
    print(f"📊 Статистика сессии:")
    print(f"   ✅ Завершено транзакций: {completed}")
    print(f"   ⏸️  Отменено транзакций:  {failed}")
    print(f"   💾 Все данные сохранены корректно")
    print(f"   🔒 Соединения с БД закрыты")
    print()
    print(f"👋 Система остановлена: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("✅ Graceful shutdown УСПЕШЕН!\n")
    
    sys.exit(0)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n⚠️  Ctrl+C перехвачен (SIGINT)")
        sys.exit(0)

