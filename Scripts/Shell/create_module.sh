#!/bin/bash

# 메뉴 옵션
options=("PresentationModule" "CommonModule")
selected=0

# 터미널 설정 저장
stty_orig=$(stty -g)

# 방향키 기반 선택 메뉴 함수
print_menu() {
    clear
    echo "📦 생성할 모듈 타입을 선택하세요 (↑↓ 방향키로 선택, Enter로 확정):"
    for i in "${!options[@]}"; do
        if [[ $i -eq $selected ]]; then
            echo -e "  > \033[32m${options[$i]}\033[0m"
        else
            echo "    ${options[$i]}"
        fi
    done
}

# 방향키 처리
while true; do
    print_menu

    # -s: silent, -n3: 3글자 읽기 (ESC + [ + A/B)
    read -rsn1 key
    if [[ $key == $'\x1b' ]]; then
        read -rsn2 rest
        key+=$rest
        if [[ $key == $'\x1b[A' ]]; then
            ((selected--))
            if ((selected < 0)); then selected=$((${#options[@]} - 1)); fi
        elif [[ $key == $'\x1b[B' ]]; then
            ((selected++))
            if ((selected >= ${#options[@]})); then selected=0; fi
        fi
    elif [[ $key == "" ]]; then
        break
    fi
done

# 모듈 이름 입력
read -p "📝 생성할 모듈 이름을 입력하세요: " name
if [[ -z "$name" ]]; then
    echo "❌ 이름은 비워둘 수 없습니다."
    stty "$stty_orig"
    exit 1
fi

# scaffold 실행
selected_option=${options[$selected]}
echo "📁 [Tuist] ( $selected_option ) 모듈 '( $name )' 생성 중..."

if ! tuist scaffold "$selected_option" --name "$name"; then
	echo "❌ 템플릿 \"$template_name\"이 없거나 문제가 발생했습니다."
	exit 1
fi

# 터미널 설정 복원
stty "$stty_orig"

