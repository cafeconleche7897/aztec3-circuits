# 1. Varsayılan Build Type Ayarı (Standart ve Güvenli)
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "No build type selected, defaulting to Release")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
    # Standart tipleri GUI (ccmake/cmake-gui) için öneri olarak belirle
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo" "RelWithAssert")
endif()

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# 2. 🚀 SMART CONFIGURATION: 'RelWithAssert' Tanımlaması
# if bloğu içinde manuel eklemek yerine, CMake'e bu tipin kurallarını öğretiyoruz.
# Bu değişkenler sadece CMAKE_BUILD_TYPE=RelWithAssert olduğunda otomatik devreye girer.

# C++ Flags: -O3 (Optimizasyon) ve -g (Debug sembolleri - assert hatası aldığınızda stack trace görebilmek için iyidir)
# DİKKAT: -DNDEBUG bilerek EKLENMEMİŞTİR. Böylece assert() çalışmaya devam eder.
set(CMAKE_CXX_FLAGS_RELWITHASSERT "-O3 -g" CACHE STRING "Flags used by the C++ compiler during RelWithAssert builds." FORCE)
set(CMAKE_C_FLAGS_RELWITHASSERT   "-O3 -g" CACHE STRING "Flags used by the C compiler during RelWithAssert builds."   FORCE)
set(CMAKE_EXE_LINKER_FLAGS_RELWITHASSERT    "" CACHE STRING "Flags used for linking binaries during RelWithAssert builds." FORCE)
set(CMAKE_SHARED_LINKER_FLAGS_RELWITHASSERT "" CACHE STRING "Flags used by the shared libraries linker during RelWithAssert builds." FORCE)

# 3. Multi-Config Generator Desteği (VS, Xcode, Ninja Multi-Config)
# IDE'de "Debug" ve "Release" yanında "RelWithAssert" seçeneğinin çıkmasını sağlar.
if(CMAKE_CONFIGURATION_TYPES)
    list(APPEND CMAKE_CONFIGURATION_TYPES RelWithAssert)
    list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "Semicolon separated list of supported configuration types." FORCE)
endif()

# 4. Doğrulama (Opsiyonel ama Zeki Kodlayıcılar Kontrol Eder)
if(CMAKE_BUILD_TYPE STREQUAL "RelWithAssert")
    message(STATUS ">>> RelWithAssert Active: Optimizations ON (-O3), Assertions ENABLED (No -DNDEBUG)")
endif()
