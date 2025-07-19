try:
    from colorama import init, Fore, Style
except ImportError:
    import subprocess
    import sys
    subprocess.check_call([sys.executable, "-m", "pip", "install", "colorama"])
    from colorama import init, Fore, Style

import time
import random
import os
import platform
import subprocess as sp

init(autoreset=True)

def clear(): os.system("cls" if platform.system() == "Windows" else "clear")

def fast_type(text, delay=0.008):
    for char in text:
        print(char, end='', flush=True)
        time.sleep(delay)
    print()

def animated_title():
    colors = [Fore.CYAN, Fore.MAGENTA, Fore.YELLOW, Fore.GREEN, Fore.RED, Fore.LIGHTBLUE_EX]
    color = random.choice(colors)
    print(color + Style.BRIGHT + "╔" + "═" * 38 + "╗")
    print(color + Style.BRIGHT + "║" + " " * 10 + "Gaming DNS Tool v1.2.3" + " " * 9 + "║")
    print(color + Style.BRIGHT + "╚" + "═" * 38 + "╝")
    print()

def header_box():
    print(Fore.WHITE + Style.BRIGHT + "┌" + "─" * 40 + "┐")
    print("│  Admin: @MahdiAGM0".ljust(42) + "│")
    print("│  Telegram: @Academi_vpn".ljust(42) + "│")
    print("└" + "─" * 40 + "┘\n")

def get_ping(dns):
    try:
        result = sp.run(['ping', '-c', '1', dns], capture_output=True, text=True)
        for line in result.stdout.splitlines():
            if "time=" in line:
                return line.split("time=")[-1].split(" ")[0]
        return "Timeout"
    except:
        return "Error"

def get_random_dns_pair():
    dns_pool = [
        ("94.140.14.14", "94.140.15.15"),
        ("9.9.9.9", "149.112.112.112"),
        ("1.1.1.1", "1.0.0.1"),
        ("185.51.200.2", "178.22.122.100"),
        ("10.202.10.11", "10.202.10.10"),
        ("185.55.103.8", "185.55.103.9"),
        ("185.55.225.25", "185.55.226.26"),
        ("156.154.70.2", "156.154.71.2")
    ]
    return random.choice(dns_pool)

def dns_output(primary, secondary):
    print(Fore.LIGHTBLUE_EX + "\n╔═════════════ 🎯 DNS RESULT ═════════════╗")
    ping1 = get_ping(primary)
    ping2 = get_ping(secondary)
    print(f"║ Primary:   {primary}   (Ping: {ping1}ms)".ljust(40) + "║")
    print(f"║ Secondary: {secondary}   (Ping: {ping2}ms)".ljust(40) + "║")
    print("╚" + "═" * 42 + "╝\n")

def get_game_list():
    games = [
        "Call of Duty Mobile", "PUBG Mobile", "Free Fire", "Fortnite", "Valorant",
        "Apex Legends", "League of Legends", "Dota 2", "Overwatch", "Minecraft",
        "CS:GO", "Rocket League", "FIFA Online", "Warzone", "Rainbow Six",
        "Arena Breakout", "Mobile Legends", "Clash of Clans", "Clash Royale",
        "Brawl Stars", "Genshin Impact", "Wild Rift", "Roblox", "ARK", "Rust",
        "Battlefield", "Elden Ring", "Destiny 2", "Diablo IV", "Honkai Impact", "Palworld"
    ]
    return games

def list_countries():
    return ["Iran", "Turkey", "UAE", "Saudi Arabia", "Qatar", "Jordan", "Iraq"]

def show_game_menu():
    clear()
    animated_title()
    header_box()
    games = get_game_list()
    for idx, game in enumerate(games, 1):
        mark = " [NEW]" if game == "Arena Breakout" else ""
        print(Fore.LIGHTYELLOW_EX + f"{idx}. {game}{mark}")
    print(Fore.LIGHTCYAN_EX + f"\n{len(games)+1}. Back")
    choice = input(Fore.YELLOW + "\nSelect your game: ")
    if choice.isdigit() and 1 <= int(choice) <= len(games):
        country_menu(games[int(choice)-1])
    elif choice == str(len(games)+1):
        main_menu()
    else:
        input(Fore.RED + "Invalid choice! Press Enter...")
        show_game_menu()

def country_menu(game):
    clear()
    animated_title()
    header_box()
    countries = list_countries()
    for idx, country in enumerate(countries, 1):
        print(Fore.LIGHTMAGENTA_EX + f"{idx}. {country}")
    print(Fore.LIGHTCYAN_EX + f"\n{len(countries)+1}. Back")
    choice = input(Fore.YELLOW + "\nSelect country: ")
    if choice.isdigit() and 1 <= int(choice) <= len(countries):
        primary, secondary = get_random_dns_pair()
        clear()
        animated_title()
        header_box()
        print(Fore.GREEN + f"🎮 DNS for {game} in {countries[int(choice)-1]}:\n")
        dns_output(primary, secondary)
        input(Fore.LIGHTWHITE_EX + "\nPress Enter to return...")
        main_menu()
    else:
        input(Fore.RED + "Invalid choice! Press Enter...")
        country_menu(game)

def download_dns():
    clear()
    animated_title()
    header_box()
    countries = ["Iran", "Germany", "USA", "Singapore"]
    for idx, c in enumerate(countries, 1):
        print(Fore.LIGHTGREEN_EX + f"{idx}. {c}")
    print(Fore.LIGHTCYAN_EX + f"\n{len(countries)+1}. Back")
    choice = input(Fore.YELLOW + "\nSelect country: ")
    if choice.isdigit() and 1 <= int(choice) <= len(countries):
        primary, secondary = get_random_dns_pair()
        clear()
        animated_title()
        header_box()
        print(Fore.GREEN + f"⬇️ Download/Unblock DNS ({countries[int(choice)-1]}):\n")
        dns_output(primary, secondary)
        input(Fore.LIGHTWHITE_EX + "\nPress Enter to return...")
        main_menu()
    else:
        input(Fore.RED + "Invalid choice! Press Enter...")
        download_dns()

def ping_test_menu():
    clear()
    animated_title()
    header_box()
    dns = input(Fore.YELLOW + "Enter a DNS to test: ")
    if dns:
        ping = get_ping(dns)
        print(Fore.GREEN + f"\nPing to {dns}: {ping} ms\n")
    else:
        print(Fore.RED + "Invalid input!")
    input(Fore.LIGHTWHITE_EX + "\nPress Enter to return...")
    main_menu()

def dns_search():
    clear()
    animated_title()
    header_box()
    query = input(Fore.YELLOW + "Search game: ").strip().lower()
    matches = [g for g in get_game_list() if query in g.lower()]
    if not matches:
        input(Fore.GREEN + "\nNo match found. Press Enter...")
        main_menu()
    else:
        for idx, g in enumerate(matches, 1):
            print(Fore.LIGHTYELLOW_EX + f"{idx}. {g}")
        choice = input(Fore.YELLOW + "\nSelect game: ")
        if choice.isdigit() and 1 <= int(choice) <= len(matches):
            country_menu(matches[int(choice)-1])
        else:
            input(Fore.RED + "Invalid choice. Press Enter...")
            main_menu()

def main_menu():
    clear()
    animated_title()
    header_box()
    fast_type(Fore.CYAN + """
1. 🎮 Gaming DNS
2. ⬇️ Download/Unblock DNS
3. 🔍 Search Game DNS
4. 📡 Ping Test DNS
5. ❌ Exit
""", delay=0.001)
    choice = input(Fore.YELLOW + "\nSelect an option: ")
    if choice == "1":
        show_game_menu()
    elif choice == "2":
        download_dns()
    elif choice == "3":
        dns_search()
    elif choice == "4":
        ping_test_menu()
    elif choice == "5":
        clear()
        print(Fore.LIGHTGREEN_EX + "Goodbye!")
        exit()
    else:
        input(Fore.RED + "Invalid choice. Press Enter...")
        main_menu()

if __name__ == "__main__":
    main_menu()
