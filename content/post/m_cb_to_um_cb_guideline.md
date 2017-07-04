+++
categories = ["category1", "category2"]
date = "2017-07-04T14:30:55+09:00"
tags = ["C++/CLI", "Programming"]
title = "C++/CLI 콜백 전달 참고 사항"
+++

    // unmanaged -> managed 를 참조 하기 위한 방법
    // reference count 는 이 친구가 올려 준다. 
    // ref. How to: Declare Handles in Native Types
    // https://msdn.microsoft.com/en-us//library/481fa11f.aspx
    // ref.2 Reference count - Stackoverflow
    // https://stackoverflow.com/questions/8458886/what-is-a-rooted-reference