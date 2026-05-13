Po restarcie maszyny środowisko wróciło do stanu domyślnego, ponieważ konfiguracja „sudo bez hasła” nie została zachowana w systemie plików.

W praktyce oznacza to, że plik:
/etc/sudoers.d/dev01
który odpowiada za wyłączenie pytania o hasło przy użyciu sudo, nie istniał po uruchomieniu systemu.

Taka sytuacja może się zdarzyć, jeśli zmiany były wykonywane na sesji, która nie została zapisana w snapshotcie maszyny wirtualnej albo jeśli system został uruchomiony z czystego obrazu Ubuntu.

Aby przywrócić poprawne działanie automatyzacji (w szczególności Ansible, które wymaga dostępu do sudo bez interakcji użytkownika), należy ponownie dodać użytkownika:

dev01

do konfiguracji sudo w trybie NOPASSWD.

Robi się to poprzez utworzenie pliku konfiguracyjnego w katalogu:
/etc/sudoers.d/

który nadpisuje domyślne zachowanie systemu i pozwala wykonywać komendy administracyjne bez wpisywania hasła.

W tym celu należy wykonać następujące komendy:

echo "dev01 ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/dev01
sudo chmod 440 /etc/sudoers.d/dev01
sudo -n true

test:
sudo -n whoami 
odpowiedź: root

Wyjaśnienie:

1. Pierwsza komenda tworzy plik konfiguracyjny i przypisuje użytkownikowi dev01 pełne uprawnienia sudo bez konieczności podawania hasła.

2. Druga komenda ustawia odpowiednie prawa dostępu do pliku (tylko odczyt dla systemu), co jest wymagane przez mechanizm sudo i jest standardową praktyką bezpieczeństwa.

3. Trzecia komenda służy jako test — jeśli zwróci kod 0, oznacza to, że konfiguracja działa poprawnie i system nie wymaga już hasła przy użyciu sudo.

Po wykonaniu tych kroków maszyna jest ponownie gotowa do uruchamiania automatyzacji Ansible, Docker oraz K3s bez interakcji użytkownika.

Jest to kluczowy element konfiguracji control node, ponieważ zapewnia pełną automatyzację procesu instalacji i eliminuje ręczne wpisywanie haseł, które blokowałyby działanie playbooków.
