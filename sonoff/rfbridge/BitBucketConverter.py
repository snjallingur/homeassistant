# usage: type into command line tool:
# python BitBucketConverter.py "AA B1 03 017C 044C 2C92 28181819081908190819081818190819081908190819081818 55" 20
# this will return something similar to:
# 'RfRaw AAB02103140168044C2C9C2818181908190819081908181819081908190819081908181855'



#-------------------------------------------------------------------------------
# Name:        BitBucketConverter.py
# Purpose:     Generate 'B0' message from received 'B1' data.
#
# Author:      gerardovf
#
# Created:     05/09/2018
#-------------------------------------------------------------------------------

import sys

# Output:
# Example: AAB035051412DE05C802D5017223A0012332232323323232322332323232322323323223233223322323323232323223323232232323233455
# 0xAA: sync start
# 0xB0: command
# 0x35: len command (dec 53)
# 0x05: bucket count
# 0x14: repeats
# buckets 0-4
# data
# 0x55: sync end

def main(szInpStr, repVal):
    #print("%s" % szInpStr)
    #print("%d" % repVal)
    listOfElem = szInpStr.split()
    #print(listOfElem)
    iNbrOfBuckets = int(listOfElem[2])
    #print("%d" % iNbrOfBuckets)
    # Start packing
    szOutAux = "AAB0xx"
    szOutAux += listOfElem[2]
    strHex = int("%0.2X" % repVal)
    #print(strHex)
    szOutAux += str(strHex)
    for i in range(0, iNbrOfBuckets):
        szOutAux += listOfElem[i + 3]
    szOutAux += listOfElem[iNbrOfBuckets + 3]
    szOutAux += listOfElem[iNbrOfBuckets + 4]
    #print(szOutAux)
    iLength = int(len(szOutAux) / 2)
    iLength -= 4
    #print(iLength)
    strHex = str("%0.2X" % iLength)
    #print(strHex)
    szOutFinal = "'RfRaw "
    szOutFinal += szOutAux.replace('xx', strHex)
    szOutFinal += "'"
    print(szOutFinal)

# In program command line put two values (received Raw between '"' and desired repeats)
# Example: "AA B1 05 12DE 05C8 02D5 0172 23A0 0123322323233232323223323232323223233232232332233223233232323232233232322323232334 55" 20
if __name__ == '__main__':
    szInpStr = sys.argv[1]
    repVal = int(sys.argv[2])
    main(szInpStr, repVal)
