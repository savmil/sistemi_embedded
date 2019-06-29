-------------------------------------------------------
--! @file
--! @brief  UART AXI IPCORE with interrupt
-------------------------------------------------------
--! Viene utilizzata la libreria IEEE
library ieee;
--! Sono utilizzati i segnali della standard logic
use ieee.std_logic_1164.all;
--! Vengono utilizzate le funzioni numeriche
use ieee.numeric_std.all;
--! libreria necessaria per la funzione or_reduce
use ieee.std_logic_misc.all;


entity UART_v1_0_S00_AXI is
	generic (
		-- Users to add parameters here
        baudrate : integer := 9600;
        clock_freq : integer := 50_000_000;
		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
	);
	port (
		-- Users to add ports here
        tx : out std_logic;
        rx : in std_logic;
        interrupt : out std_logic;
		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		S_AXI_AWVALID	: in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		S_AXI_AWREADY	: out std_logic;
		-- Write data (issued by master, acceped by Slave) 
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		S_AXI_WVALID	: in std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		S_AXI_WREADY	: out std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		S_AXI_BVALID	: out std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		S_AXI_BREADY	: in std_logic;
		-- Read address (issued by master, acceped by Slave)
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		S_AXI_ARVALID	: in std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		S_AXI_ARREADY	: out std_logic;
		-- Read data (issued by slave)
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		S_AXI_RVALID	: out std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		S_AXI_RREADY	: in std_logic
	);
end UART_v1_0_S00_AXI;

architecture arch_imp of UART_v1_0_S00_AXI is

	-- AXI4LITE signals
	signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_bvalid	: std_logic;
	signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 2;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 8
	signal slv_reg0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg1	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg3	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg5	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
	signal slv_reg7	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	signal aw_en	: std_logic;
	
	signal uart_status_reg	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg3_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   	signal slv_reg7_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);

    
    
    signal reset : std_logic;                       
	
	
    ----- Signal used for interrutp logic -------------   
    signal pending_intr : std_logic_vector(1 downto 0);                     --! interruzioni pendenti
    signal pending_intr_tmp : std_logic_vector(1 downto 0);                 --! delay intr_pending

    -- alias esplicativi della logica  utilizzati per maggiore leggibilità del codice 
    alias global_intr: std_logic is slv_reg4(0);                            --! enable interruzioni IP CORE
    alias intr_mask : std_logic_vector(1 downto 0) is slv_reg5(1 downto 0); --! maschera interruzioni rda(1) e tx_busy(0). Mettendo il relativo bit ad uno si 
                                                                            --! abilita la lina di interruzione
    alias ack_intr  : std_logic_vector(1 downto 0) is slv_reg7(1 downto 0); --! segnale di ack. Il bit 0 da ack all'interuzione della trasmissione, 
                                                                            --! il bit 1 a quello dela ricezione. Logica 1 attiva
       
    signal changed_bits : std_logic_vector(1 downto 0);
    
    signal tx_busy_falling_detect  : std_logic;                             --! vale 1 quando viene rilevato il falling_edge di tx_busy
    signal rx_rising_detect : std_logic;                                    --! alto quando viene rilevato il rising_edge di RDA
    signal last_stage    : std_logic_vector(1 downto 0);
    signal current_stage : std_logic_vector(1 downto 0);
    signal change_detected : std_logic;
    
    
	--! @brief UART
	--! @details componente contenente un ricevitore e un trasmettitore che implementano il protocollo UART. Consulatare documentazione esterna.
	component UART is
    Generic(baudrate : integer := 9600;                         --! baudrate della trasmissione
		    clock_freq : integer := 50_000_000);                --! frequenza del clock in ingresso
	 Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rx : in  STD_LOGIC;                                  --! linea ricezione
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);         --! segnale per il dato da trasmettere
           tx_en : in  STD_LOGIC;                               --! segnale per iniziare la trasmissione, va riportato a 0 manualmente prima di inziare un nuovo trasferimento
           OE : out  STD_LOGIC;                                 --! OVERRUN error
           tx_busy : out  STD_LOGIC;                            --! segnale che si alza all'inzio del trasferimento e si abbassa a trasferimento completato
           FE : out  STD_LOGIC;                                 --! frame error
           PE : out  STD_LOGIC;                                 --! parity error
           tx : out  STD_LOGIC;                                 --! linea seriale trasmissione
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);       --! dato ricevuto
           RDA : out  STD_LOGIC);                               --! segnale il cui valore alto indica che un nuovo dato ricevuto è dispobile
    end component UART;

begin
	-- I/O Connections assignments

	S_AXI_AWREADY	<= axi_awready;
	S_AXI_WREADY	<= axi_wready;
	S_AXI_BRESP	<= axi_bresp;
	S_AXI_BVALID	<= axi_bvalid;
	S_AXI_ARREADY	<= axi_arready;
	S_AXI_RDATA	<= axi_rdata;
	S_AXI_RRESP	<= axi_rresp;
	S_AXI_RVALID	<= axi_rvalid;
	-- Implement axi_awready generation
	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	      aw_en <= '1';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- slave is ready to accept write address when
	        -- there is a valid write address and write data
	        -- on the write address and data bus. This design 
	        -- expects no outstanding transactions. 
	           axi_awready <= '1';
	           aw_en <= '0';
	        elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
	           aw_en <= '1';
	           axi_awready <= '0';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	-- Implement axi_awaddr latching
	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- Write Address latching
	        axi_awaddr <= S_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_wready generation
	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1') then
	          -- slave is ready to accept write data when 
	          -- there is a valid write address and write data
	          -- on the write address and data bus. This design 
	          -- expects no outstanding transactions.           
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	-- Implement memory mapped register select and write logic generation
	-- The write data is accepted and written to memory mapped registers when
	-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	-- select byte enables of slave registers while writing.
	-- These registers are cleared when reset (active low) is applied.
	-- Slave register write enable is asserted when valid address and data are available
	-- and the slave is ready to accept the write address and write data.
	slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

	process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
	      slv_reg2 <= (others => '0');
	      slv_reg3 <= (others => '0');
	      slv_reg4 <= (others => '0');
	      slv_reg5 <= (others => '0');
	      slv_reg6 <= (others => '0');
	      slv_reg7 <= (others => '0');
	    else
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	      if (slv_reg_wren = '1') then
	        case loc_addr is
	          when b"000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 0
	                slv_reg0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 1
	                slv_reg1(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 2
	                slv_reg2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 3
	                slv_reg3(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"100" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 4
	                slv_reg4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"101" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 5
	                slv_reg5(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"110" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 6
	                slv_reg6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"111" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 7
	                slv_reg7(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when others =>
	            slv_reg0 <= slv_reg0;
	            slv_reg1 <= slv_reg1;
	            slv_reg2 <= slv_reg2;
	            slv_reg3 <= slv_reg3;
	            slv_reg4 <= slv_reg4;
	            slv_reg5 <= slv_reg5;
	            slv_reg6 <= slv_reg6;
	            slv_reg7 <= slv_reg7;
	        end case;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement write response logic generation
	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp   <= "00"; --need to work more on the responses
	    else
	      if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arready generation
	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_araddr  <= (others => '1');
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_arready <= '1';
	        -- Read Address latching 
	        axi_araddr  <= S_AXI_ARADDR;           
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arvalid generation
	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
	        -- Valid read data is available at the read data bus
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
	        -- Read data is accepted by the master
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;

	-- Implement memory mapped register select and read logic generation
	-- Slave register read enable is asserted when valid address is available
	-- and the slave is ready to accept the read address.
	slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid) ;

	process (slv_reg0, slv_reg1, uart_status_reg, slv_reg3_out, slv_reg4, slv_reg5, slv_reg6, slv_reg7_out, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	begin
	    -- Address decoding for reading registers
	    loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	    case loc_addr is
	      when b"000" =>
	        reg_data_out <= slv_reg0;
	      when b"001" =>
	        reg_data_out <= slv_reg1;
	      when b"010" =>
	        reg_data_out <= uart_status_reg;
	      when b"011" =>
	        reg_data_out <= slv_reg3_out;
	      when b"100" =>
	        reg_data_out <= slv_reg4;
	      when b"101" =>
	        reg_data_out <= slv_reg5;
	      when b"110" =>
	        reg_data_out <= slv_reg6;
	      when b"111" =>
	        reg_data_out <= slv_reg7_out;
	      when others =>
	        reg_data_out  <= (others => '0');
	    end case;
	end process; 

	-- Output register or memory read data
	process( S_AXI_ACLK ) is
	begin
	  if (rising_edge (S_AXI_ACLK)) then
	    if ( S_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_reg_rden = '1') then
	        -- When there is a valid read address (S_AXI_ARVALID) with 
	        -- acceptance of read address by the slave (axi_arready), 
	        -- output the read dada 
	        -- Read address mux
	          axi_rdata <= reg_data_out;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;


	-- Add user logic here
    reset <= not S_AXI_ARESETN;             -- UART ha bisogno di un reset non negato, a differenza del BUS AXI

    inst_uart : UART 
    generic map(
            baudrate => baudrate,           
			clock_freq => clock_freq
			)
	port map ( 
	       clock => S_AXI_ACLK,
           reset => reset,
           rx => rx,
           data_in => slv_reg0(7 downto 0),   
           tx_en => slv_reg1(0),
           OE => uart_status_reg(0),                  
           tx_busy => uart_status_reg(4),     
           FE => uart_status_reg(1),
           PE => uart_status_reg(2),
           tx => tx,
           data_out => slv_reg3_out(7 downto 0),     
           RDA => uart_status_reg(3)            
           );
           
           
           
    -- process utilizzato per captare varizione dei segnali RDA(bit 3) e tx_busy(bit 4)
    -- la sintesi da due FF in cascata
    -------------------------------------------------------------------------------
    --!  @brief Campiona i segnali di cui si vuole verificare la generazione 
    --!		di un interrupt
    --!
    --! @param[in]   S_AXI_ACLK		clock del bus AXI
    --! @param[in]   uart_status_reg	valori del UART da campionare
    -------------------------------------------------------------------------------
    status_reg_sampling : process (S_AXI_ACLK,uart_status_reg)
    begin
    if (rising_edge (S_AXI_ACLK)) then
        if ( S_AXI_ARESETN = '0' ) then
            last_stage <= (others => '0');
            current_stage <= (others => '0');
        else
            last_stage <= uart_status_reg(4 downto 3);
            current_stage <= last_stage; 
        end if;    
    end if;
    end process;
    
    
     tx_busy_falling_detect <= not last_stage(1) and  current_stage(1);    -- detect falling edge tx_busy
     rx_rising_detect <= not current_stage(0) and last_stage(0);           -- detect rising edge RDA
    
    
    changed_bits <= (rx_rising_detect & tx_busy_falling_detect) and intr_mask; -- and con la intr_mask perchè sono interessato a vedere l'edge del sengale
                                                                               -- solo se la relativa interruzione è abilitata   
   
    change_detected <= or_reduce(changed_bits);                                -- Segnale che indica se è stato rilevata una variazione di tx_busy o RDA 
                                                                               -- alla quale si è interessati         


       pending_intr_tmp <= pending_intr;


    -- process per la gestizione della logica di interruzione pedente 
    -- e meccanismo di ack per rimuovere l'interruzione pendente
    -------------------------------------------------------------------------------
    --! @brief Gestisce il registro pending
    --! @details Per la descrizione del componente riferirsi alla documentazione 
    --!		 dell' intero design
    --! @param[in]   S_AXI_ACLK		clock del bus AXI
    --! @param[in]   change_detected	identifica l' avvenimento dell' interruput
    --!					su un segnale abilitato
    --! @param[in]   ack_intr		cattura un segnale di ack generato dal 
    --!					driver che gestisce l' eccezione
    -------------------------------------------------------------------------------
    intr_pending : process (S_AXI_ACLK, change_detected, ack_intr,pending_intr_tmp,changed_bits)
    begin
    if (rising_edge (S_AXI_ACLK)) then
        if(S_AXI_ARESETN = '0')then
            pending_intr <= (others => '0');
        else
            if (change_detected = '1') then                                        -- se c'è richiesta di interruzione su una delle due line
                pending_intr <= pending_intr_tmp or changed_bits;                  -- aggiungi la richiesta alle interruzioni pendenti
            elsif (or_reduce(ack_intr)='1') then                                  -- se viene dato un ack
                    pending_intr <= pending_intr_tmp and (not ack_intr);           -- rimuovi la richiesta pendente relativa
            else
                    pending_intr <= pending_intr_tmp;                             --altrimenti pending_intr resta al suo valore precedente
        end if;
       end if;   
    end if;
    end process;
    
    -- process per gestire l'unica linea di interruzione 
    -- in unscita dal componente
    -------------------------------------------------------------------------------
    --! @brief Disabilita l' interrupt nel caso di reset del bus e tiene alto il
    --! segnale di interrupt finchè rimane pendente
    --! @details Per la descrizione del componente riferirsi alla documentazione 
    --!		 dell' intero design
    --! @param[in]   S_AXI_ACLK		clock del bus AXI
    --! @param[in]   pending_intr	registro che identifica le interruzioni 
    --!					pendenti
    -------------------------------------------------------------------------------
    inst_irq : process(S_AXI_ACLK,pending_intr,global_intr)
    begin
        if (rising_edge (S_AXI_ACLK)) then
            if ( S_AXI_ARESETN = '0' ) then
                    interrupt <= '0';
            else
                if (or_reduce(pending_intr) = '1' and global_intr = '1') then  -- Se c'è almeno un interruzione pendente e le interruzioni globali sono abilitate
                    interrupt <= '1';                                          -- interrupt = '1'
                else
                    interrupt <= '0';                                          -- altrimenti 0
                end if;
            end if;
        end if;
    end process;
    
        
    slv_reg7_out(1 downto 0) <= pending_intr; 
           
           
           
           
	-- User logic ends

end arch_imp;
