# Handshake_protocol_of_AXI4  
  
>>This is a little project and understangding of the handshake_protocol of AXI4 and the  realization in a register way.  

## Handshake_protocol
>>As we all know that the AXI4 bus have 5 channels and all of them follow the hand_protocol.And this protocal transmit messages by the signs of VALID & READY.  
>>>The source asserts VALID to indicate that its data or address is able to transimit.  
>>>The destination asserts READY to indicate that destination is ready to recive the data/address of source.
>>Only if both of them are up level and the data/address can be transmitted.And de-assert the two signs after all transmissions.
>>This protocol has a superiority that both the source and destination can control the speed of messages transimit.  
>>And there are three cases according to this protocol:  
  
### 

