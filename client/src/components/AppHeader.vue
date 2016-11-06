<template lang="html">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title"><router-link to="/feed">Mon député de poche</router-link></span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation">
                <button class="mdl-button mdl-button--icon" v-on:click="logout()"><span class="material-icons">exit_to_app</span></button>
                <router-link class="mdl-navigation__link" to="/search"><span class="material-icons">search</span></router-link>
            </nav>
        </div>
    </header>
</template>

<script>
export default {
    methods: {
        logout(){
            this.$store.dispatch('LOG_OUT');
            this.$router.replace('search')
        }
    }
};
</script>

<style lang="scss" scoped>
    @import '../styles/vars';

    .mdl-layout__header {
        display: block;
        position: fixed;
        background: transparent;

        &:before {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            content: '';
            background: $glowy-bg;
            opacity: .98;
            z-index: -1;
        }

        @supports (backdrop-filter: blur(2px)) {
            -webkit-backdrop-filter: blur(2px);

            &:before {
                opacity: .94 !important;
            }
        }

        .mdl-layout__header-row {
            padding-left: 16px;
        }
    }
</style>
