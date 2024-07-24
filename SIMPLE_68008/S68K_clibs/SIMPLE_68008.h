/* SIMPLE-68008 Card Defines */
#ifndef SIMPLE_68008_h

/* DUART Addresses 	*/
#define DUART_MRA_ADR	0x0F0000	/* Mode Register A (R/W)			*/
#define DUART_SRA_ADR	0x0F0002	/* Status Register A (r)			*/
#define DUART_CSRA_ADR	0x0F0002	/* Clock Select Register A (w)		*/
#define DUART_CRA_ADR	0x0F0004	/* Commands Register A (w)			*/
#define DUART_RBA_ADR	0x0F0006	/* Receiver Buffer A (r)			*/
#define DUART_TBA_ADR 	0x0F0006	/* Transmitter Buffer A (w) 		*/
#define DUART_IPC_ADR 	0x0F0008	/* Input Port Change Register (R)	*/
#define DUART_ACR_ADR 	0x0F0008	/* Aux. Control Register (W) 		*/
#define DUART_ISR_ADR 	0x0F000A	/* Interrupt Status Register (R)	*/
#define DUART_IMR_ADR 	0x0F000A	/* Interrupt Mask Register (W)		*/
#define DUART_MRB_ADR 	0x0F0010	/* Mode Register B (R/W)			*/
#define DUART_SRB_ADR 	0x0F0012	/* Status Register B (R)			*/
#define DUART_CSRB_ADR	0x0F0012	/* Clock Select Register B (W)		*/
#define DUART_CRB_ADR 	0x0F0014	/* Commands Register B (W)			*/
#define DUART_RBB_ADR 	0x0F0016	/* Reciever Buffer B (R)			*/
#define DUART_TBB_ADR 	0x0F0016	/* Transmitter Buffer B (W)			*/
#define DUART_IVR_ADR	0x0F0018	/* Interrupt Vector Register (R/W) 	*/
#define DUART_INU_ADR 	0x0F001A	/* Input port (unlatched) (R) 		*/
#define DUART_OPC_ADR 	0x0F001A	/* Output port config (W)			*/
#define DUART_OPS_ADR 	0x0F001C	/* Start Counter Command (R)		*/
#define DUART_OPS_ADR 	0x0F001C	/* Output port Set (W)				*/
#define DUART_OPR_ADR 	0x0F001E	/* Stop Counter Command (R)			*/
#define DUART_OPR_ADR 	0x0F001E	/* Output port Clear (W)			*/

#else
#define SIMPLE_68008_h
#endif
