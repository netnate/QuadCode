symbols = ('а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р',
     'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я', 'a', 'b', 'c', 'd', 'e',
     'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
     'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ',', ';', ':', '-',
     '_', ' ', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '+', '=', '\"', '№', '~', '?',
     '\\', '/', '|', '[', ']', '{', '}', '`', '\'', '<', '>')
# кортеж со всеми символами


print(' ')
print(' ')
print('QuadCode 2.0')
print('')
d = 0  # индекс символа из введённого символа
k = 0
res = ''  # переменная, в которой хранится резульат (EN/DE)
z = 0
operation = 0
a4 = ''  # переменная, содержащая код элемента
m1 = 0  # индекс символа из введённого символа
m = ''  # индекс символа из ключевого слова
n = ''  # 1 символ из кода символа
c = 0  # код одного символа
# text = ''  # расшифрованный текст

print('1 -- Encrypt') #DELETE
print('2 -- Decrypt') #DELETE
print('') #DELETE
while operation != 1 and operation != 2:  #DELETE
    operation = int(input('Operation: ')) #DELETE

keyWord = str(input('Key-word: '))  # ввод ключевого слова #DELETE
setkw = set(keyWord)
while len(setkw) != 4 or len(keyWord) != 4:
    print('Key-word does not meet the condition')
    keyWord = str(input('Key-word: ')).lower()
    setkw = set(keyWord)  # проверка ключевого слова на условия
txt = str(input('Text: ')).lower()  # ввод текста для шифровки
l = int(len(txt))  # длина введённого текста

#DELETE

if operation == 1:
    # шифровка (EN)
    for i in range(l):
        if txt[d] in symbols:
            f = symbols.index(txt[d])  # забор символа из кортежа по его индексу, используя элемент d из введённого текста
            a4 = ''
            if f == 0:
                a4 = '0'
            while f > 0:
                a4 = str(f % 4) + a4  # добавление перед кодом элемента часть его кода. Пока код не станет полноценным, т.е. пока f больше 0
                f //= 4
            a4 = str(a4)
        else:
            a4 += '1123'  # если символ не найден, ему присваивается значение '?'
        while len(a4) != 4:  # если код символа содержит менее 4 символов, к нему в начало добавляются 0
            a4 = '0' + a4
        for j in range(4):
            res += (keyWord[int(a4[z])])
            z += 1
        z = 0
        d += 1
    print(res)
else:
    #расшифровка (DE)
    l = int(len(txt) / 4)  # длина введённого текста

    for i in range(l):
        for j in range(4):
            n = txt[m1]
            m += str(keyWord.index(n))
            m1 += 1 # индекс символа из введённого символа
        c = int(m[0]) * 64 + int(m[1]) * 16 + int(m[2]) * 4 + int(m[3])
        res += symbols[c]
        c = 0
        m = ''
    print(res)