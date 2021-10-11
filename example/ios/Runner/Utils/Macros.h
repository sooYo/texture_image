//
//  Macros.h
//  TextureImage
//
//  Created by Sooyo on 2021/10/11.
//
//  TI stands for "Texture Image"

// Run a non-nil block
#define TIExecBlock(b, ...) if (b != nil) {b(__VA_ARGS__);}

// Weak-strong dance
#define TIWeakify(VAR) __weak __typeof__(VAR)(VAR##_weak_) = (VAR)
#define TIStrongify(VAR) __strong __typeof__(VAR) VAR = (VAR##_weak_)
