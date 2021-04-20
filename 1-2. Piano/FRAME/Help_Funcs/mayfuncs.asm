	;==================================================================
	; Requires: numer (up to 65535) to print in ax
	;
	; Returns:  ----
	;
	; Damages:  ax, bx, cx, dx
	;==================================================================
	PrintNumber proc

		cmp ax, 10
		jb easy_out	; ���� ����� < 10, ��� ����� ������ �������, ������� '0'
		or ah, ah
		jz norm_out     ; ����  9 < ����� < 256, �� ��� ����� ������� �� �����
		jmp hard_out    ; � ���� ����� >= 256, �� ��� ������� ������ ���������


      easy_out:	mov dl, al
		add dl, '0'
		mov ah, 02h
		int 21h
		ret

      norm_out:	mov bh, 10
		xor dx, dx
		xor cx, cx	; �������� �������
		
		digitn:	div bh

			add ah, '0'     ; ���������� ����� ����� �����
			mov dl, ah
			push dx         ; � ����������� � � �����
			inc cx		; ���������� ��������

			xor ah, ah	; �������������� ax

		        or al, al       ; ��������� ����� �����, ���� ��� ����
			jnz digitn
		
		jmp output
		
	
      hard_out:	mov bx, 10
		xor dx, dx
		xor cx, cx
		
		digith:	div bx

			add dx, '0'
			push dx
			inc cx

			xor dx, dx

			or ax, ax
			jnz digith

		jmp output
			

	output: mov ah, 02h
		pop dx
		int 21h
		loop output

	ret
	endp