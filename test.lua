local module = dofile("bin/brotli.lua")

module.init()

local function strToArr(str)
    return {str:byte(1,-1)}
end

local compLen,compBuf = {2000},{}
for i=1,2000 do compBuf[i] = 0 end
assert(module.bindings.global.BrotliEncoderCompress(1,22,0,strToArr("Hello World"),compLen,compBuf) == 1)

local fixed = {}
for i=1,compLen[1] do fixed[i] = compBuf[i] end

local outLen,outBuf = {2000},{}
assert(module.bindings.global.BrotliDecoderDecompress(fixed,outLen,outBuf) == 1)

for i=1,outLen[1] do io.write(string.char(outBuf[i])) end
