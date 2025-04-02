/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./index.html",
        "./src/**/*.{vue,js,ts,jsx,tsx}",
    ],
    theme: {
        extend: {},
    },
    // 禁用可能与Element Plus冲突的基础样式
    corePlugins: {
        preflight: false,
    },
    // 确保Tailwind CSS不会覆盖Element Plus的样式
    important: false,
    // 添加前缀以避免冲突
    prefix: 'tw-',
    plugins: [],
} 