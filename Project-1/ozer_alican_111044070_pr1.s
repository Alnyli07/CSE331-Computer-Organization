	.data
welcome:    .asciiz "Alican OZER-111044070
1.Drawing Stars
2.Stock Market Game\n"
str_menu:	.asciiz "Select to program(1-2)"	
str_p1:	.asciiz "Enter a number(1-21)"
str_error1:	.asciiz "invalid choice it would be 1 or 2!!"
str_error2:	.asciiz "Number would be 1-21 and odd!!!"
str_newline:	.asciiz "\n"
str_empty:	.asciiz "  "
str_star:	.asciiz "* "
str_week:	.asciiz "\nWeek "
str_dollar:	.asciiz "1.Dollar: "
str_gold:	.asciiz "2.Gold  : "
str_bond:	.asciiz "3.Bond  : "
str_money:	.asciiz "#Money  : "
str_total:	.asciiz "#Total  : "
str_submenu:	.asciiz "1.Buy \n2.Sell \n3.Pass \n"
str_player1:	.asciiz "--- Player 1 --- \n"
str_player2:	.asciiz "--- Player 2 --- \n"
str_turn1:	.asciiz "Player "
str_turn2:	.asciiz "'s turn : "
str_time:	.asciiz "what is the date and time?(ddmmyyyyhhmm) "
str_blank:	.asciiz "\n"
sub_buy:    .asciiz "---BUY---\n"
sub_sell:   .asciiz "---SELL---\n"
sub_choice: .asciiz "Your choice : "
sub_amount: .asciiz "Amount : "
less_money: .asciiz ">>>>No enough money, try again<<<<\n"
less_unit:  .asciiz "<<<<No enough investment, try again>>>>\n"
winp1:  .asciiz "\n<<<Player 1 won the game.>>>\n"
winp2:  .asciiz "\n<<<Player 2 won the game.>>>\n"

	.text
	.globl main
	.ent	main
main:	
	li $v0, 4				# print_string
	la $a0, welcome
	syscall
	la $a0, str_menu	 	# address of string to print
	syscall 				# print the string

	li $v0, 5				# read_int
	syscall					# call read int
	move $t0, $v0			# move entry to t0

	addi $t1, $zero, 1
	addi $t2, $zero, 2
	beq $t1, $t0, procedure1
	beq $t2, $t0, procedure2
	li $v0 ,4
	la $a0 ,str_error1
	syscall

	##end of file
	li $v0, 10				#exit signal
	syscall
.end	main

procedure1:
	li $v0, 4				# print_string
	la $a0, str_p1	 		# address of string to print
	syscall 				# print the string

	li $v0, 5				# read_int
	syscall					# call read int
	move $a2, $v0			# move entry to t0

	slti $t1, $a2, 22 		# ? int<21 t1=1
	slti $t2, $a2, 0		# ? int<0 t2=1
	xor $t3, $t1, $t2		# if(t1=1 and t2=0) t3=1 
	beq $t3, $zero, exit2	#  
	addi $t5, $zero, 2		# if correct
	divu $a2, $t5			# number/2
	mfhi $t6				# number mod 2(odd)
	beq $t6, $zero, exit2
	jal draw_figure			#call procedure
	
	li $v0, 10				# exit signal
	syscall

empty:
	li $v0, 4				# print_string
	la $a0, str_empty 		# address of string to print
	syscall
	jr $ra
star:	
	li $v0, 4				# print_string
	la $a0, str_star 		# address of string to print
	syscall 
	jr $ra

draw_figure:
	add $s0, $zero, $a2			# n
	addi $t0, $s0, 1 		#t0=n+1
	move $t3, $t0			#t3=1(i)
	addi $t1, $zero, 2 		#t1=2(first)
	divu $t0, $t1 			#(n+1)/2
	mflo $t0				#t0=(n+1)/2(inner)
	addi $t2, $s0, -1
	divu $t2, $t1 			#t2/2
	mflo $t2 				#t2=(n-1)/2(loop)

	move $t3, $zero			#i=0;
	addi $a3, $zero, 1
#a3 herzaman 1 olmalı karşılaştırma için
#a1 i brach te kullan
	loop1a:
		li $v0, 4
		la $a0, str_newline
		syscall

		addi $t5, $t0, -1
		slt $a1, $t5, $t3		#control j<n-i
		bne $a3, $a1, else1

#asagıda 15 tane for dongusu var		
		addi $t4, $zero, 1 #t4=j=1		
		loop2a:	
			sub $a1, $s0, $t3
			slt $a1, $t4, $a1
			bne $a3, $a1, d1
			jal empty	
			addi $t4, $t4, 1		
			j loop2a
	d1:
	move $t4, $zero
		loop3a:
			slt $a1, $t4, $t1
			bne $a3, $a1, d2
			jal star
			addi $t4, $t4, 1
			j loop3a

	d2:
	move $t4, $zero
		loop4a:			
			addi $a1, $zero, 2
			sub $a1, $s0, $a1
			slt $a1, $t4, $a1
			bne $a3, $a1, d3
			jal empty
			addi $t4, $t4, 1			
			j loop4a
	d3:
	move $t4, $zero
		loop5a:			
			slt $a1, $t4, $t1
			bne $a3, $a1, d4
			jal star
			addi $t4, $t4, 1
			j loop5a
	d4:
	addi $t3, $t3, 1
	addi $t1, $t1, 1
	slt $a1, $t3, $s0
	beq $a3, $a1, loop1a
	j others
		
#******************	
	else1:
		addi $t4, $zero, 1 #t4=j=1
		sub $t6, $s0, $t3
		slt $a1, $t4, $t6
		bne $a3, $a1, d5		
		loop6a:		
			jal empty	
			addi $t4, $t4, 1
			slt $a1, $t4, $t6	
			bne $a3, $a1, d5				
			j loop6a
	d5:
	move $t4, $zero
	sll $t5 ,$t3, 1 	#t3*2
	addi $t5, $t5, 1
	loop7a:
		jal star
		addi $t4, $t4, 1			
		slt $a1, $t4, $t5
		bne $a3, $a1, d6
		j loop7a

	d6:
	addi $t3, $t3, 1
	slt $a1, $t3, $s0
	beq $a3, $a1, loop1a
		 
others:

	addi $t0, $zero, 0 		#ix
	add $t1, $zero, $s0 	#iy  loop=t2
	addi $t3, $zero, 1 		#i
	addi $a3, $zero, 1 		#a3=1 for comparison

	loop1b:
		addi $t5, $s0, 1 	#n+1

		li $v0, 4
		la $a0, str_newline
		syscall

		slt $a1, $t3, $t5
		bne $a3, $a1, loop1bout
				#if in altı
		

		bne $a3, $t2, else2
		#jal empty
		addi $t7, $s0, -1
		addi $t5, $zero, 2
		divu $t7, $t5
		mflo $t7
		addi $t4, $zero, 0
		loop8b:
			slt $t5, $t4, $t7
			bne $a3, $t5, loop8bout
			jal empty
			addi $t4, $t4, 1
			j loop8b

		loop8bout:
		addi $t4, $zero, 0
		loop2b:
			slt $t5, $t4, $t0
			bne $a3, $t5, loop2bout
			jal empty
			addi $t4, $t4, 1
			j loop2b

		loop2bout:
		addi $t0, $t0, 1

		addi $t4, $zero, 0	
		loop3b:
			slt $t5, $t4, $t1
			bne $a3, $t5, loop3bout
			jal star
			addi $t4, $t4, 1
			j loop3b

		loop3bout:
		addi $t1, $t1, -2
	addi $t3, $t3, 1
	j loop1b

		else2:
			addi $t4, $zero, 0
			loop4b:
				slt $t5, $t4, $t3
				bne $a3, $t5, loop4bout
				jal empty
				addi $t4, $t4, 1
				j loop4b
		loop4bout:
		add $t4, $zero, $t2
		
		loop5b:
			slt $t5, $zero, $t4
			bne $a3, $t5, loop5bout
			jal star
			addi $t4, $t4, -1
			j loop5b

		loop5bout:
		addi $t4, $zero, 0
		addi $t5, $s0, -2

		loop6b:
			slt $t6, $t4, $t5
			bne $a3, $t6, loop6bout
			jal empty
			addi $t4, $t4, 1
			j loop6b

		loop6bout:
		add $t4, $zero, $t2
		loop7b:
			slt $t5, $zero, $t4
			bne $a3, $t5, loop7bout
			jal star
			addi $t4, $t4, -1
			j loop7b

		loop7bout:
			addi $t2, $t2, -1

	addi $t3, $t3, 1
	j loop1b

	loop1bout:	#loop1b nın sonu

	li $v0, 10				# exit signal
	syscall
	jr $ra

exit2:
	li $v0, 4				# print_string
	la $a0, str_error2		# load error message
	syscall

	li $v0, 10				# exit signal
	syscall

###--procedure2------------##
procedure2:
	jal print_time 			#print time request
	    
    li $v0, 5
    syscall
    move $s7, $v0  			# move integer to s7

    addi $t4, $zero, 1		#reset for week counter (1-12)
    addi $t5, $zero, 7		#reset for dolar random (7-13)
    addi $t6, $zero, 5		#reset for gold random (18-22)
    addi $t7, $zero, 51		#reset for bond random (25-75)

    #initializing stack
    addi $sp, $sp, -40 		# for 10 values + ra
    addi $t3, $zero, 100 	#they has 100 dollar
    sw $t3, 4($sp)  		#player 1's money	
    sw $zero, 8($sp)  		#player 1's dollar	
    sw $zero, 12($sp)  		#player 1's gold
    sw $zero, 16($sp)  		#player 1's bond	
    sw $t3, 20($sp)  		#player 1's total	
    sw $t3, 24($sp)  		#player 2's money	
    sw $zero, 28($sp)  		#player 2's dollar	
    sw $zero, 32($sp)  		#player 2's gold
    sw $zero, 36($sp)  		#player 2's bond	
    sw $t3, 40($sp)  		#player 2's total
    addi $s4, $zero, 1      #for select player

loop_week:
    addi $t2, $zero, 1
    addi $t3, $zero, 12
    slt $t3, $t4, $t3
    bne $t3, $t2, exit1
    #generate random numbers    
  	divu $s7, $t5
   	mfhi $t5
  	addi $t5, $t5, 7
  	divu $s7, $t6
   	mfhi $t6
  	addi $t6, $t6, 18
  	divu $s7, $t7
   	mfhi $t7
  	addi $t7, $t7, 25
    sll $s7, $s7, 1 #regenerate random number each turn
  	jal print_blank
  	jal print_blank
    j calc_total    #calculate with new values
    step1:
        addi $t2, $zero, 1
      	jal print_week		#print week and week number
      	move $a0, $t4
      	jal print_int
      	jal print_blank
      	jal print_blank
      	jal print_dollar  	#print dollar and value
      	move $a0, $t5 	
      	jal print_int
      	jal print_blank
      	jal print_gold		#print gold and value
      	move $a0, $t6  	
      	jal print_int
      	jal print_blank
      	jal print_bond		#print bond and value
      	move $a0, $t7  	
      	jal print_int
      	jal print_blank
      	jal print_blank
      	jal print_player1	#player1  
       	jal print_money  	#print money
       	lw $a0, 4($sp)
       	jal print_int
       	jal print_blank
       	jal print_dollar 	#print dollar and value
       	lw $a0, 8($sp)
       	jal print_int
       	jal print_blank
       	jal print_gold 		#print gold and value
       	lw $a0, 12($sp)
       	jal print_int
       	jal print_blank
       	jal print_bond 		#print bond and value
       	lw $a0, 16($sp)
       	jal print_int
       	jal print_blank
       	jal print_total 	#print total and value
       	lw $a0, 20($sp)
       	jal print_int
       	jal print_blank
        jal print_blank
       	jal print_player2 	#player2
       	jal print_money
       	lw $a0, 24($sp)
       	jal print_int
       	jal print_blank
       	jal print_dollar 	#print dollar and value
       	lw $a0, 28($sp)
       	jal print_int
       	jal print_blank
       	jal print_gold 		#print gold and value
       	lw $a0, 32($sp)
       	jal print_int
       	jal print_blank
       	jal print_bond 		#print bond and value
       	lw $a0, 36($sp)
       	jal print_int
       	jal print_blank
       	jal print_total 	#print total and value
       	lw $a0, 40($sp)
       	jal print_int
       	jal print_blank
        jal print_submenu 	#print buy-sell value

        jal print_turn 		#print player number
        li $v0, 5
        syscall
        move $t0, $v0
        addi $s1, $zero, 1
        addi $s2, $zero, 2
        addi $s3, $zero, 3
        bne $s4, $s1, p2

        beq $t0, $s1, fn_buy        
        beq $t0, $s2, fn_sell
        beq $t0, $s3, fn_pass
        j step1

        p2:
        beq $t0, $s1, fn_buy2        
        beq $t0, $s2, fn_sell2
        beq $t0, $s3, fn_pass
        j step1
    #lw $ra, $s0
    #jr $ra
exit1:
	lw $t0, 20($sp) #player 1 point
    lw $t1, 40($sp) #player 2 point
    addi $t2, $zero, 1
    slt $t0, $t0, $t1
    beq $t0, $t2, p2win

    li $v0, 4
    la $a0, winp1
    syscall
    j exit3
    p2win:
        li $v0, 4
        la $a0, winp2
        syscall

    exit3:
    addi $sp, $sp, 40
	li $v0, 10				#exit signal
	syscall
.end main

fn_pass:    
    addi $a1, $zero, 1
    beq $a1, $s4, change_player #player 1 ise
    #player 2 ise

    addi $s4, $s4, -1 #player--
    addi $t4, $t4, 1 #week++
    j loop_week


change_player:

    addi $s4, $s4, 1 #player++
    j step1
    
#/****************************/
fn_buy:
    #show variables and values'
    li $v0, 4
    la $a0, sub_buy
    syscall
    jal print_money 		#print money and value
    lw $a0, 4($sp)
    li $v0, 1
    syscall
    jal print_blank
    jal print_dollar 		#print dollar and value
    move $a0, $t5
    li $v0, 1
    syscall
    jal print_blank
    jal print_gold 			#print gold and value
    move $a0, $t6
    li $v0, 1
    syscall
    jal print_blank
    jal print_bond 			#print bond and value
    move $a0, $t7
    li $v0, 1
    syscall
    jal print_blank
    li $v0, 4
    la $a0, sub_choice
    syscall
    li $v0, 5 #get choice info
    syscall
    move $t0, $v0 #choice
    jal print_blank
    li $v0, 4
    la $a0, sub_amount
    syscall
    li $v0, 5 #get amount info
    syscall
    move $t1, $v0   #amount
    #select unit for buy
    beq $t0, $s1, buy_dollar
    beq $t0, $s2, buy_gold
    beq $t0, $s3, buy_bond
    j step1 #incorrent choice

    buy_dollar:
        #control money is enough
        lw $t2, 4($sp) #get money
        mul $t3, $t1, $t5 #price*piece for dollar
        addi $t3, $t3, -1 #tutar-1
        slt $a0, $t3, $t2 #tutar<money
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessmoney #go lessmoney if money<tutar
        mul $t2, $t1, $t5   #calc tutar 
        lw $t3, 4($sp)      #get money
        subu $t3, $t3, $t2  #money-tutar
        sw $t3, 4($sp)      #money update
        lw $t2, 8($sp)      #get dollar
        add $t2, $t1, $t2   #dollar+buy
        sw $t2, 8($sp)      #dollar update
        j calc_total
    buy_gold:
        #control money is enough
        lw $t2, 4($sp)      #get money
        mul $t3, $t1, $t6   #price*piece for gold
        addi $t3, $t3, -1   #tutar-1
        slt $a0, $t3, $t2   #tutar<money
        addi $a1, $zero, 1  #for compare
        bne $a0, $a1, lessmoney #go lessmoney if money<tutar
        mul $t2, $t1, $t6   #calc tutar 
        lw $t3, 4($sp)      #get money
        subu $t3, $t3, $t2  #money-tutar
        sw $t3, 4($sp)      #money update
        lw $t2, 12($sp)     #get gold
        add $t2, $t1, $t2   #gold+buy
        sw $t2, 12($sp)     #gold update
        jal calc_total
    buy_bond:
        #control money is enough
        lw $t2, 4($sp)      #get money
        mul $t3, $t1, $t7   #price*piece for bond
        addi $t3, $t3, -1   #tutar-1
        slt $a0, $t3, $t2   #tutar<money
        addi $a1, $zero, 1  #for compare
        bne $a0, $a1, lessmoney #go lessmoney if money<tutar
        mul $t2, $t1, $t7   #calc tutar 
        lw $t3, 4($sp)      #get money
        subu $t3, $t3, $t2  #money-tutar
        sw $t3, 4($sp)      #money update
        lw $t2, 16($sp)     #get bond
        add $t2, $t1, $t2   #bond+buy
        sw $t2, 16($sp)     #gold update
        j calc_total
fn_sell:
    #show variables and values'
    li $v0, 4
    la $a0, sub_sell
    syscall
    jal print_money 	#print money and value
    lw $a0, 4($sp)
    li $v0, 1
    syscall
    jal print_blank
    jal print_dollar 	#print dollar and value
    move $a0, $t5
    li $v0, 1
    syscall
    jal print_blank
    jal print_gold 		#print gold and value
    move $a0, $t6
    li $v0, 1
    syscall
    jal print_blank
    jal print_bond 		#print bond and value
    move $a0, $t7
    li $v0, 1
    syscall
    jal print_blank
    li $v0, 4
    la $a0, sub_choice
    syscall
    li $v0, 5 #get choice info
    syscall
    move $t0, $v0 #choice
    jal print_blank
    li $v0, 4
    la $a0, sub_amount
    syscall
    li $v0, 5 #get amount info
    syscall
    move $t1, $v0   #amount
    #select unit for sell
    beq $t0, $s1, sell_dollar
    beq $t0, $s2, sell_gold
    beq $t0, $s3, sell_bond
    j step1 #incorrent choice
    sell_dollar:
        #control dollar is enough
        lw $t2, 8($sp) #get dollar
        addi $t3, $t1, -1 #amouth-1
        slt $a0, $t3, $t2 #amouth<exist
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessunit #go lessunit
        mul $t2, $t1, $t5   #calc tutar 
        lw $t3, 4($sp)      #get money
        add $t3, $t3, $t2  #money+tutar
        sw $t3, 4($sp)      #money update
        lw $t2, 8($sp)      #get dollar
        subu $t2, $t2, $t1   #dollar-buy
        sw $t2, 8($sp)      #dollar update
        j calc_total
    sell_gold:
        #control gold is enough
        lw $t2, 12($sp) #get gold
        addi $t3, $t1, -1 #amouth-1
        slt $a0, $t3, $t2 #amouth<exist
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessunit #go lessunit
        mul $t2, $t1, $t6   #calc tutar 
        lw $t3, 4($sp)      #get money
        add $t3, $t3, $t2  #money+tutar
        sw $t3, 4($sp)      #money update
        lw $t2, 12($sp)      #get gold
        subu $t2, $t2, $t1   #gold-buy
        sw $t2, 12($sp)      #gold update
        j calc_total
    sell_bond:
        #control bond is enough
        lw $t2, 16($sp) #get bond
        addi $t3, $t1, -1 #amouth-1
        slt $a0, $t3, $t2 #amouth<exist
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessunit #go lessunit
        mul $t2, $t1, $t7   #calc tutar 
        lw $t3, 4($sp)      #get money
        add $t3, $t3, $t2  #money+tutar
        sw $t3, 4($sp)      #money update
        lw $t2, 16($sp)      #get bond
        subu $t2, $t2, $t1   #bond-buy
        sw $t2, 16($sp)      #bond update
        j calc_total

#/********************************/
fn_buy2:
    #show variables and values'
    li $v0, 4
    la $a0, sub_buy
    syscall
    jal print_money 	#print money and value
    lw $a0, 24($sp)
    li $v0, 1
    syscall
    jal print_blank
    jal print_dollar 	#print dollar and value
    move $a0, $t5
    li $v0, 1
    syscall
    jal print_blank
    jal print_gold 		#print gold and value
    move $a0, $t6
    li $v0, 1
    syscall
    jal print_blank
    jal print_bond 		#print bond and value
    move $a0, $t7
    li $v0, 1
    syscall
    jal print_blank
    li $v0, 4
    la $a0, sub_choice
    syscall
    li $v0, 5 #get choice info
    syscall
    move $t0, $v0 #choice
    jal print_blank
    li $v0, 4
    la $a0, sub_amount
    syscall
    li $v0, 5 #get amount info
    syscall
    move $t1, $v0   #amount
    #select unit for buy
    beq $t0, $s1, buy_dollar2
    beq $t0, $s2, buy_gold2
    beq $t0, $s3, buy_bond2
    j step1 #incorrent choice

    buy_dollar2:
        #control money is enough
        lw $t2, 24($sp) #get money
        mul $t3, $t1, $t5 #price*piece for dollar
        addi $t3, $t3, -1 #tutar-1
        slt $a0, $t3, $t2 #tutar<money
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessmoney #go lessmoney if money<tutar
        mul $t2, $t1, $t5   #calc tutar 
        lw $t3, 24($sp)      #get money
        subu $t3, $t3, $t2  #money-tutar
        sw $t3, 24($sp)      #money update
        lw $t2, 28($sp)      #get dollar
        add $t2, $t1, $t2   #dollar+buy
        sw $t2, 28($sp)      #dollar update
        j calc_total
    buy_gold2:
        #control money is enough
        lw $t2, 24($sp)      #get money
        mul $t3, $t1, $t6   #price*piece for gold
        addi $t3, $t3, -1   #tutar-1
        slt $a0, $t3, $t2   #tutar<money
        addi $a1, $zero, 1  #for compare
        bne $a0, $a1, lessmoney #go lessmoney if money<tutar
        mul $t2, $t1, $t6   #calc tutar 
        lw $t3, 24($sp)      #get money
        subu $t3, $t3, $t2  #money-tutar
        sw $t3, 24($sp)      #money update
        lw $t2, 32($sp)     #get gold
        add $t2, $t1, $t2   #gold+buy
        sw $t2, 32($sp)     #gold update
        jal calc_total
    buy_bond2:
        #control money is enough
        lw $t2, 24($sp)      #get money
        mul $t3, $t1, $t7   #price*piece for bond
        addi $t3, $t3, -1   #tutar-1
        slt $a0, $t3, $t2   #tutar<money
        addi $a1, $zero, 1  #for compare
        bne $a0, $a1, lessmoney #go lessmoney if money<tutar
        mul $t2, $t1, $t7   #calc tutar 
        lw $t3, 24($sp)      #get money
        subu $t3, $t3, $t2  #money-tutar
        sw $t3, 24($sp)      #money update
        lw $t2, 36($sp)     #get bond
        add $t2, $t1, $t2   #bond+buy
        sw $t2, 36($sp)     #gold update
        j calc_total
fn_sell2:
    #show variables and values'
    li $v0, 4
    la $a0, sub_sell
    syscall
    jal print_money 	#print money and value
    lw $a0, 24($sp)
    li $v0, 1
    syscall
    jal print_blank
    jal print_dollar 	#print dollar and value
    move $a0, $t5
    li $v0, 1
    syscall
    jal print_blank
    jal print_gold 		#print gold and value
    move $a0, $t6
    li $v0, 1
    syscall
    jal print_blank
    jal print_bond 		#print bond and value
    move $a0, $t7
    li $v0, 1
    syscall
    jal print_blank
    li $v0, 4
    la $a0, sub_choice
    syscall
    li $v0, 5 #get choice info
    syscall
    move $t0, $v0 #choice
    jal print_blank
    li $v0, 4
    la $a0, sub_amount
    syscall
    li $v0, 5 #get amount info
    syscall
    move $t1, $v0   #amount
    #select unit for sell
    beq $t0, $s1, sell_dollar2
    beq $t0, $s2, sell_gold2
    beq $t0, $s3, sell_bond2
    j step1 #incorrent choice
    sell_dollar2:
        #control dollar is enough
        lw $t2, 28($sp) #get dollar
        addi $t3, $t1, -1 #amouth-1
        slt $a0, $t3, $t2 #amouth<exist
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessunit #go lessunit
        mul $t2, $t1, $t5   #calc tutar 
        lw $t3, 24($sp)      #get money
        add $t3, $t3, $t2  #money+tutar
        sw $t3, 24($sp)      #money update
        lw $t2, 28($sp)      #get dollar
        subu $t2, $t2, $t1   #dollar-buy
        sw $t2, 28($sp)      #dollar update
        j calc_total
    sell_gold2:
        #control gold is enough
        lw $t2, 32($sp) #get gold
        addi $t3, $t1, -1 #amouth-1
        slt $a0, $t3, $t2 #amouth<exist
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessunit #go lessunit
        mul $t2, $t1, $t6   #calc tutar 
        lw $t3, 24($sp)      #get money
        add $t3, $t3, $t2  #money+tutar
        sw $t3, 24($sp)      #money update
        lw $t2, 32($sp)      #get gold
        subu $t2, $t2, $t1   #gold-buy
        sw $t2, 32($sp)      #gold update
        j calc_total
    sell_bond2:
        #control bond is enough
        lw $t2, 36($sp) #get bond
        addi $t3, $t1, -1 #amouth-1
        slt $a0, $t3, $t2 #amouth<exist
        addi $a1, $zero, 1 #for compare
        bne $a0, $a1, lessunit #go lessunit
        mul $t2, $t1, $t7   #calc tutar 
        lw $t3, 24($sp)      #get money
        add $t3, $t3, $t2  #money+tutar
        sw $t3, 24($sp)      #money update
        lw $t2, 36($sp)      #get bond
        subu $t2, $t2, $t1   #bond-buy
        sw $t2, 36($sp)      #bond update
        j calc_total

#//************************/
calc_total:
    lw $t0, 4($sp)      #get money
    lw $t1, 8($sp)      #get dollar
    mul $t1, $t1, $t5   #calc total of dollar
    lw $t2, 12($sp)     #get gold
    mul $t2, $t2, $t6   #calc total of gold
    lw $t3, 16($sp)     #get bond
    mul $t3, $t3, $t7   #calc total of bond
    move $s0, $zero     #zero summing 
    add $s0, $t0, $t1   #sum money+dollar
    add $s0, $s0, $t2   #sum total+gold
    add $s0, $s0, $t3   #sum total+bond
    sw $s0, 20($sp)     #total update

    lw $t0, 24($sp)     #get money
    lw $t1, 28($sp)     #get dollar
    mul $t1, $t1, $t5   #calc total of dollar
    lw $t2, 32($sp)     #get gold
    mul $t2, $t2, $t6   #calc total of gold
    lw $t3, 36($sp)     #get bond
    mul $t3, $t3, $t7   #calc total of bond
    move $s0, $zero     #zero summing 
    add $s0, $t0, $t1   #sum money+dollar
    add $s0, $s0, $t2   #sum total+gold
    add $s0, $s0, $t3   #sum total+bond
    sw $s0, 40($sp)     #total update
    j step1
    #/***********************/
lessmoney:      li $v0, 4               # print_string
                la $a0, less_money        # address of string to print
                syscall
                j fn_buy
lessunit:       li $v0, 4               # print_string
                la $a0, less_unit        # address of string to print
                syscall
                j fn_sell
print_int:		li  $v0, 1    	# system call code for print_int
                syscall    		# print it
                jr $ra
print_week:	    li $v0, 4				# print_string
                la $a0, str_week 		# address of string to print
                syscall
                jr $ra
print_dollar:	li $v0, 4				# print_string
                la $a0, str_dollar 		# address of string to print
                syscall
                jr $ra
print_gold:	    li $v0, 4				# print_string
                la $a0, str_gold 		# address of string to print
                syscall
                jr $ra
print_bond:	    li $v0, 4				# print_string
                la $a0, str_bond 		# address of string to print
                syscall
                jr $ra
print_money:	li $v0, 4				# print_string
                la $a0, str_money 		# address of string to print
                syscall
                jr $ra
print_total:	li $v0, 4				# print_string
                la $a0, str_total 		# address of string to print
                syscall
                jr $ra
print_submenu:	li $v0, 4				# print_string
                la $a0, str_submenu 		# address of string to print
                syscall
                jr $ra
print_player1:	li $v0, 4				# print_string
                la $a0, str_player1 	# address of string to print
                syscall
                jr $ra
print_player2:	li $v0, 4				# print_string
                la $a0, str_player2 	# address of string to print
                syscall
                jr $ra
print_time:	    li $v0, 4				# print_string
                la $a0, str_time	 	# address of string to print
                syscall
                jr $ra
print_blank:	li $v0, 4				# print_string
                la $a0, str_blank	 	# address of string to print
                syscall
                jr $ra
print_turn:	    li $v0, 4				# print_string
                la $a0, str_turn1	 	# address of string to print
                syscall

                move $a0, $s4
                li $v0, 1
                syscall

            	li $v0, 4				# print_string
                la $a0, str_turn2	 	# address of string to print
                syscall
                jr $ra