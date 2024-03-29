import random

if __name__ == "__main__":
    old_cur = 0
    cur = 0
    file = open("sensor_record.txt", "w")
    for count in range(0, 72000):
        choice = random.randint(0, 7)
        if choice == 0:
            file.write("el_1_1")
        elif choice == 1:
            file.write("el_2_1")
        elif choice == 2:
            file.write("st_1_1")
        elif choice == 3:
            file.write("st_2_1")
        elif choice == 4:
            file.write("st_3_1")
        elif choice == 5:
            file.write("st_4_1")
        elif choice == 6:
            file.write("st_5_1")
        elif choice == 7:
            file.write("st_6_1")
        file.write(" " + str(cur).zfill(10) + '\n')
        cur = cur + random.randint(100, 1000)
        if (cur / 1000) > (old_cur / 1000 + 1):
            old_cur = cur
            cur = cur + 10
            file.write(str(random.randint(0, 4095)).zfill(6) + " " + str(cur).zfill(10) + '\n')
    file.close()
