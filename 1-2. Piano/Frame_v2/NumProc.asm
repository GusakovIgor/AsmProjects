.model tiny
.code
org 100h

; Constants ===========================

BASE_NAME_SIZE equ 5
MAX_INP_LEN equ 20

;======================================



Start:		
	;==================================================================
	; Requires: Input buffer with constant size MAX_INP_LEN (up to 254)
	;
	; Returns:  Char buffer with beginnig at si + 1, with it's
	;	    length in [si]
	;
	; Damages:  ah, si, dx
	;==================================================================
	global GetString
	GetString proc

		mov ah, 0ah
		mov dx, offset Input
		mov si, dx
		mov byte ptr [si], MAX_INP_LEN
		
		int 21h
		inc si
	ret
	endp



        ;==================================================================
	; Requires: pointer on buffer in si (where si + 1 - beginning of the string 
	;				      and [si]    - length of string)
	;
	; Returns:  number from the buffer in ax
	;
	; Damages:  ax, bx, cx, dx
	;==================================================================
	global ReadNumber
	ReadNumber proc
		
		xor ax, ax
		xor cx, cx
		xor di, di

		mov cl, [si]
		mov dx, cx	; ��������� ���������� ����
		inc si		; ��������� � �������
		cld
		
    store_nums:	sub byte ptr [si], '0'
		lodsb
		push ax		; ����� ������ ����� � ����
                loop store_nums
                           
		mov cx, dx      ; ���������� � cx ���-�� ����
		mov bx, 1	; ��������� ��� ������ �����		
      
  count_number: pop ax          ; ��������� ����� ����� �� �����

		mul bx          ; �������� ����� �� ������� 10
                add di, ax	; ���������� ������������ � ���������� ����� (�������� �����)

		mov ax, 10	; �������� bx �� 10
		mul bx
		mov bx, ax
		
		loop count_number
		

	  quit: mov ax, di
                
	ret
	endp



Input:	db MAX_INP_LEN dup (?)
   
end Start