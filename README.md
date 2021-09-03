# Handshake_protocol_of_AXI4  
  
This is a little project and understangding of the handshake_protocol of AXI4 and the  realization in a register way.  

## Handshake_protocol
As we all know that the AXI4 bus have 5 channels and all of them follow the hand_protocol.And this protocal transmit messages by the signs of VALID & READY.  
1.The source asserts VALID to indicate that its data or address is able to transimit.  
2.The destination asserts READY to indicate that destination is ready to recive the data/address of source.  
Only if both of them are up level and the data/address can be transmitted.And de-assert the two signs after all transmissions.  
This protocol has a superiority that both the source and destination can control the speed of messages transimit.    
And there are three cases according to this protocol:  
  
### 1.VALID before READY  
>If VALID arrives before READY.This signal and the valid data can't de-assert till the READY arrives and receive the data.  
>This can sure that the destination won't miss this valid data.  
>[pic]  
>If the destination is not ready yet but the source starts to generate new valid datas,the need more registers to store them.  
  
### 2.READY before VALID  
>If READY arrives before VALID.The destination will wait VALID to receive the data.   
>Once VALID appers ,the destination starts to get data.When destination is't able to get new datas,READY de-assert.    
>[pic]  
>The READY can de-assert and assert casually before VALID arrives.And this won't influence the data transmission.  
  
### 3.VALID with READY  
>If READY and VALID arrive simultaneously just transmit data.   
>And the transmission can keep many clks if the two signals keep high-level.    
>[pic]  
  
## Register scheme  
Some time we need to register signal to timing repair.
  



