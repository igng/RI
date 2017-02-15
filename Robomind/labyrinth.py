def main():
    f = open("./labyrinth.map", 'w')
    f.write("map:\n")
    square_map(f)
    # hexagonal_map(f)
    f.close()

def insert_after(f, n, c):
    for i in range(n):
        f.write(" ")
    f.write(c)
    f.write('\n')

def insert_for(f, n, c):
    for i in range(n):
        f.write(c)
    f.write('\n')

def hexagonal_map(f):
    max_size = 30
    half_size = max_size/2
    string = 'A'
    for i in range(half_size + 1):
        insert_after(f, half_size - i, (2*i + max_size)*string)
    for i in range(half_size, 0, -1):
        insert_after(f, half_size - i, (2*i + max_size)*string)

def square_map(f):
    max_size = 40
    for i in range(max_size):
        insert_for(f, 1, max_size*'A')

main()
