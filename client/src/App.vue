<template>
    <div>
        <app-header></app-header>
        <div class="page-container">
            <router-view></router-view>
        </div>
    </div>
</template>

<script>
import AppHeader from './components/AppHeader.vue'

export default {
    components: {
        AppHeader
    }
};
</script>

<style lang="scss">
    @import '~normalize.css';
    @import 'styles/vars';
    @import 'styles/atoms/anchors';
    @import 'styles/atoms/buttons';
    @import 'styles/atoms/list';

    body {
        font-family: 'Open Sans', serif;
        font-size: 100%;
    }

    * {
        box-sizing: border-box;
    }

    p {
        line-height: 1.2em;
    }

    .material-icons {
        vertical-align: middle;
    }
</style>

<style lang="scss" scoped>
    .page-container {
        margin: 50px auto 0;
        max-width: 700px;
    }
</style>
