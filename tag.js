// using one character represent your device
const device = process.argv[2] ? process.argv[2][0] : 'e'

const genTagCode = (device) => {
    const _d = new Date()
    const _fa = [
        device,
        (_d.getFullYear() % 2000) - 18,
        _d.getMonth() + 1,
        _d.getDate(),
        _d.getHours(),
        Math.round(_d.getMinutes() / 2),
    ]
    return _fa
        .map((f) => {
            if (typeof f == 'number') return f.toString(36)
            return f
        })
        .join('')
}

console.log(`Tag has been generated: \x1b[34m${genTagCode(device)}`)
