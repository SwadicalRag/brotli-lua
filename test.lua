local module = dofile("bin/brotli.pure.lua")

module.init()

local function strToArr(str)
    local out = {} for i=1,#str do out[i] = str:byte(i,i) end return out
end

local inputStr = ("Hello World"):rep(10000)

local compBuf = {__wasmMaxLen = #inputStr * 2}
local t = os.clock()
assert(module.bindings.global.BrotliEncoderCompress(
    5,
    22,
    module.bindings.BrotliEncoderMode.BROTLI_MODE_GENERIC,
    strToArr(inputStr),
    compBuf
),"Compression failed")
print("Compression took "..(os.clock() - t).."s")

print("Compression ratio: "..(#inputStr / compBuf.len()).."x")

t = os.clock()
local outBuf = {__wasmMaxLen = #inputStr}
assert(module.bindings.global.BrotliDecoderDecompress(compBuf,outBuf,"Decompression failed"))
print("Decompression took "..(os.clock() - t).."s")

-- for i=1,outBuf.len() do io.write(string.char(outBuf[i])) end
