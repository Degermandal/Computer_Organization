	.data 
explanation: .asciiz "I={1,2,3,4,5}\nYou can enter 4 set for the program\nElements of the set should be between 1 and 6\nYou should enter your elements with space (example: 1 2 3 4)\n"
setString: .asciiz "Set " 
#explanation2: .asciiz "Please enter a set: (elements of the set should be between 1 and 6)"
#explanation3: .asciiz "You should enter your elements with space (example: 1 2 3 4)"
space: .asciiz " "
newline: .asciiz "\n"
colon: .asciiz ": "
char: .space 2

showString: .asciiz "\nShow sets "

I: .word 1,2,3,4,5
set1: .space 80 
set2: .space 80 
set3: .space 80
set4: .space 80

	.text
li $v0, 4
la $a0, explanation
syscall

main:
li $t5, 1 # 4 defa donmesi icin tutulan counter
la $s1, set1 #set1 arrayinin adresini aldim
 
Loop: 
beq $t5, 5, finish # 4 tane set girildiginde looptan cikacak
#setString mesajini ekrana yazdir
la $a0, setString 
li $v0, 4  
syscall 

la $a0, ($t5) #kacinci set oldugunu tutan counter
beq $t5, 2, forSet2 #4 farkli set icin adres tanimlama
beq $t5, 3, forSet3
beq $t5, 4, forSet4
forSet2:
la $s1, set2
forSet3:
la $s1, set3
forSet4:
la $s1, set4

li $v0, 1 # set sayini yazar
syscall 

la $a0, colon # : noktalama isaretini yazar
li $v0, 4 
syscall

readLoop:
jal readChar #readChar label'ina git (label sonlaninca tekrar readloop'a doner)
lb $t0, char #
sb $t0, 0($s1) #set arraylerindeki elemanlari haziya kaydet

lb $t1, newline #
beq $t0, $t1, counter  #eger newline ise elemani almayi birak
lb $t1, space #
beq $t0, $t1, readLoop # eger bosluk girildiyse eleman almaya devam et
addi $s1, $s1, 1 # arrayde ilerle
j readLoop 
 
readChar: 
li $v0, 8  
la $a0, char #char'in adresini al
li $a1, 2 # 2 olmasinin nedeni char + string
syscall 
jr $ra #readLoop'a tekrar don
 
counter:
addi $t5, $t5, 1 
j Loop 

finish:
addi $t5, $t5, -4 # tekrar kullamak icin
la $s1, set1 # tekrar array adresini al
show:
beq $t5, 5, end 
la $a0, showString 
li $v0, 4  
syscall 

la $a0, ($t5) 
beq $t5, 2, forSet2o
beq $t5, 3, forSet3o
beq $t5, 4, forSet4o
forSet2o:
la $s1, set2
forSet3o:
la $s1, set3
forSet4o:
la $s1, set4

li $v0, 1
la $a0, colon 
li $v0, 4 
syscall 

li $t3, 1 # farkli bir counter

stringToInteger: 
beq $t3, 5, oCounter 
addi $t3,$t3,1 
lb $a0,($s1) # 
lb $t1, newline
beq $a0, $t1, end #newline kontrolu eger char newline ise bitir programi
 
addi $a0, $a0,-48 # bunun anlami stringi integer'a cevir
li $v0, 1 
syscall 

la $a0, space 
li $v0, 4 
syscall 

addi $s1, $s1, 1 
j stringToInteger

oCounter:
addi $t5, $t5, 1 
j show 

end: 
li $v0, 10 
syscall
 
