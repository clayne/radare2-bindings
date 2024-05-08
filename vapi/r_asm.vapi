/* radare - LGPL - Copyright 2010-2024 - pancake */

namespace Radare {
/**
 * Radare2 Assembler Module
 */
[Compact]
[CCode (cheader_filename="r_asm.h", cname="RAsm", free_function="r_asm_free", cprefix="r_asm_")]
public class RAsm {
	/**
	 * Architectures supported.
	 */
	[CCode (cprefix="R_ASM_ARCH_", cname="int")]
	public enum Arch {
		NONE,
		X86,
		ARM,
		PPC,
		M68K,
		JAVA,
		MIPS,
		SPARC,
		CSR,
		MSIL,
		OBJD,
		BF,
		SH,
		Z80,
		I8080,
		ARC
	}

	/**
	 * The supported assembler syntax variations.
	 */
	[CCode (cprefix="R_ASM_SYNTAX_", cname="int")]
	public enum Syntax {
		/**
		 * Use default syntax provided by the disassembler
		 */
		NONE,
		/**
		 * Intel syntax
		 */
		INTEL,
		/**
		 * AT&T syntax
		 */
		ATT,
		/**
		 * Microsoft Assembler syntax
		 */
		MASM,
		/**
		 * Always use numeric registers
		 */
		REGNUM,
		/**
		 * Use JZ instead of JE on x86
		 */
		JZ
	}

	/**
	 * The different types of fields in opcodes.
	 */
	[CCode (cprefix="R_ASM_MOD_", cname="int")]
	public enum Mod {
		/**
		 * A raw value, like 6DEF20h in {{{ mov eax, 6DEF20h }}}
		 */
		RAWVALUE,
		/**
		 * A literal value, as in {{{ push -1 }}}
		 */
		VALUE,
		/**
		 * The destination register. EBP in {{{ MOV EBP, ESP }}}
		 */
		DSTREG,
		/**
		 * The first source register. EBX in {{{ SUB EDX, EBX }}}
		 */
		SRCREG0,
		/**
		 * The second source register, for example in {{{ PUSHA AX, CX, DX }}}
		 */
		SRCREG1,
		/**
		 * The third source register.
		 */
		SRCREG2
	}

	/**
	 * Models decompiled assembly code.
	 */
	[Compact]
	[CCode (cname="RAsmCode", cprefix="r_asm_code_", free_function="r_asm_code_free", unref_function="r_asm_code_free")]
	public class Code {
		int len;
		uint8 bytes;
		string assembly;
		// RList equs
		uint64 code_offset;
		uint64 data_offset;
		int code_align;
		//public string buf_hex;
		public string get_hex();
		public string equ_replace(string s);
		public bool set_equ(string k, string v);
	}

	/**
	 * The syntax.
	 */
	// public Syntax syntax;
	public uint64 pc;
	/**
	 * The list of active plugins.
	 */
	public RList<RAsm.Plugin> plugins;
	public RList<RAsm.Plugin> get_plugins();

	public RAsm();
	public bool use(string name);
/*
	public bool set_arch(string name, int bits);
	public bool set_bits(int bits);
	public bool set_syntax(Syntax syntax);
	public bool set_pc(uint64 addr);
	public bool set_big_endian(bool big);
*/
	// TODO: Use Code? instead of op??
	public int disassemble(RAnal.Op op, uint8* buf, int length);
	/**
	 * Assemble provided instruction into an Op, returns instruction size in bytes.
	 */
	public int assemble(RAnal.Op op, string buf);
	public Code? mdisassemble(uint8 *buf, int length);
	public Code? massemble(string buf);
	// public Code? assemble_file(string file);

	public string to_string(uint64 addr, uint8* buf, int len);
	public uint8* from_string(uint64 addr, string str, out int len);

	/* TODO: not directy defined here */
	public void free();

	/**
	 * Represents Radare2 assembly plugins.
	 */
	[Compact]
	[CCode (cname="RAsmPlugin", destroy_function="", free_function="")]
	public class Plugin {
		/**
		 * The plugin name.
		 */
		public string name;
		/**
		 * The architecture the plugin supports.
		 */
		public string arch;
		/**
		 * The CPUs the plugin supports.
		 */
		public string cpus;
		/**
		 * The plugin description.
		 */
		public string desc;
		/**
		 * The license for the plugin.
		 */
		public string license;
		/**
		 * The user data pointer;
		 */
		public void *user;
		/**
		 * Supported bit sizes.
		 */
		public int bits;
		/**
		 * The callback to be notified when the code is modified.
		 */
//		public RAsmModifyCallback modify;
	}
}
}
